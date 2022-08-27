#!/bin/sh

cpu_temp0="0.00"
cpu_temp1="0.00"
cpu_temp2="0.00"
cpu_temp3="0.00"

gpu_temp="0.00"
gpu_draw="0.00"

nvme_1_temp="0.00"
nvme_2_temp="0.00"

wireless_temp="0.00"

mem_free="0G"
zpool_free="0G"


if [[ "$(cat /sys/class/drm/card0-DP-1/dpms)" == "On" ]]
then
  sensor_out=$(sensors -j)

  cpu_temp0=$(echo $sensor_out | jq '."nct6798-isa-0290".CPUTIN.temp2_input' | xargs printf '%.*f\n' 1 $a)
  cpu_temp1=$(echo $sensor_out | jq '."k10temp-pci-00c3".Tctl.temp1_input' | xargs printf '%.*f\n' 1 $a)
  cpu_temp2=$(echo $sensor_out | jq '."k10temp-pci-00c3".Tccd1.temp3_input' | xargs printf '%.*f\n' 1 $a)
  cpu_temp3=$(echo $sensor_out | jq '."k10temp-pci-00c3".Tccd2.temp4_input' | xargs printf '%.*f\n' 1 $a)

  gpu_temp=$(echo $sensor_out | jq '."amdgpu-pci-0c00".junction.temp2_input' | xargs printf '%.*f\n' 1 $a)
  gpu_draw=$(echo $sensor_out | jq '."amdgpu-pci-0c00".PPT.power1_average' | xargs printf '%.*f\n' 0 $a)

  nvme_1_temp=$(echo $sensor_out | jq '."nvme-pci-0100"."Sensor 2".temp3_input' | xargs printf '%.*f\n' 1 $a)
  nvme_2_temp=$(echo $sensor_out | jq '."nvme-pci-0400"."Sensor 2".temp3_input' | xargs printf '%.*f\n' 1 $a)

  wireless_temp=$(echo $sensor_out | jq '."iwlwifi_1-virtual-0".temp1.temp1_input' | xargs printf '%.*f\n' 1 $a)

  mem_free=$(vmstat -S m -s | rg 'free memory' | awk '{ print $1 }' | xargs -I {} eva "{} / 1024" | xargs printf '%.*f\n' 1 $a)"G"
  zpool_free=$(zpool get -H -o value free rpool)
fi

echo -n "{\"text\": \"  CPU <span color='#aaaaaa'>$cpu_temp0°C</span> [<span color='#aaaaaa'>$cpu_temp1°C $cpu_temp2°C $cpu_temp3°C</span>] · GPU <span color='#aaaaaa'>$gpu_temp°C</span> [<span color='#aaaaaa'>$gpu_draw W</span>] · SSDs <span color='#aaaaaa'>$nvme_1_temp°C $nvme_2_temp°C</span> · WiFi <span color='#aaaaaa'>$wireless_temp°C</span>      RAM <span color='#aaaaaa'>$mem_free</span>      RAID <span color='#aaaaaa'>$zpool_free</span>\", \"tooltip\": \"\", \"alt\": \"\", \"class\": \"\" }"


#!/bin/sh

cpu_temp="0.00"

gpu_temp="0.00"
gpu_draw="0.00"

nvme_1_temp="0.00"
nvme_2_temp="0.00"

wireless_temp="0.00"

mem_free="0G"
zpool_free="0G"


if [[ "$(swaymsg -t get_outputs -r | jq -e '.[] | select(.name=="DP-3") | .dpms')" == "true" ]]
then
  sensor_out=$(sensors -j)

  cpu_temp=$(echo $sensor_out | jq '."k10temp-pci-00c3".Tccd2.temp4_input' | xargs printf '%.*f\n' 1 $a)

  gpu_temp=$(echo $sensor_out | jq '."amdgpu-pci-0c00".junction.temp2_input' | xargs printf '%.*f\n' 1 $a)
  gpu_draw=$(echo $sensor_out | jq '."amdgpu-pci-0c00".slowPPT.power1_average' | xargs printf '%.*f\n' 0 $a)

  nvme_1_temp=$(echo $sensor_out | jq '."nvme-pci-0100"."Sensor 2".temp3_input' | xargs printf '%.*f\n' 1 $a)
  nvme_2_temp=$(echo $sensor_out | jq '."nvme-pci-0400"."Sensor 2".temp3_input' | xargs printf '%.*f\n' 1 $a)

  wireless_temp=$(echo $sensor_out | jq '."iwlwifi_1-virtual-0".temp1.temp1_input' | xargs printf '%.*f\n' 1 $a)

  mem_free=$(vmstat -S m -s | rg 'free memory' | awk '{ print $1 }' | xargs -I {} eva "{} / 1024" | xargs printf '%.*f\n' 1 $a)"G"
  zpool_free=$(zpool get -H -o value free rpool)
fi

echo -n "{\"text\": \"  CPU <span color='#aaaaaa'>$cpu_temp°C</span> · GPU <span color='#aaaaaa'>$gpu_temp°C</span> [<span color='#aaaaaa'>$gpu_draw W</span>] · SSDs <span color='#aaaaaa'>$nvme_1_temp°C $nvme_2_temp°C</span> · WiFi <span color='#aaaaaa'>$wireless_temp°C</span>      RAM <span color='#aaaaaa'>$mem_free</span>      RAID <span color='#aaaaaa'>$zpool_free</span>\", \"tooltip\": \"\", \"alt\": \"\", \"class\": \"\" }"


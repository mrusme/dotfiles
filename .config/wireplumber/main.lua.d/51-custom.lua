rule_quick319 = {
  matches = {
    {
      { "node.name", "matches", "alsa_output.pci-0000_0c_00.1.hdmi-stereo-extra4" },
    },
  },
  apply_properties = {
    ["node.description"] = "LG Display",
    ["node.nick"] = "LG Display",
  },
}

table.insert(alsa_monitor.rules, rule_quick319)

rule_quick210 = {
  matches = {
    {
      { "node.name", "matches", "alsa_output.pci-0000_0c_00.1.hdmi-stereo" },
    },
  },
  apply_properties = {
    ["node.description"] = "LG Display",
    ["node.nick"] = "LG Display",
  },
}

table.insert(alsa_monitor.rules, rule_quick210)

rule_motum2 = {
  matches = {
    {
      { "node.name", "matches", "alsa_output.usb-MOTU_M2_M2AE029AS5-00.Direct__hw_M2__sink" },
    },
  },
  apply_properties = {
    ["node.description"] = "Motu M2",
    ["node.nick"] = "Motu M2",
  },
}

table.insert(alsa_monitor.rules, rule_motum2)

rule_nommo = {
  matches = {
    {
      { "node.name", "matches", "alsa_output.pci-0000_0e_00.4.analog-stereo" },
    },
  },
  apply_properties = {
    ["node.description"] = "Nommo",
    ["node.nick"] = "Nommo",
    ["device.description"] = "Nommo",
    ["device.nick"] = "Nommo",
    ["device.product.name"] = "Nommo",
  },
}

table.insert(alsa_monitor.rules, rule_nommo)

rule_starbook = {
  matches = {
    {
      { "node.name", "matches", "alsa_output.pci-0000_03_00.6.pro-output-0" },
      { "node.name", "matches", "alsa_output.pci-0000_03_00.6.analog-stereo" },
    },
  },
  apply_properties = {
    ["node.description"] = "StarBook",
    ["node.nick"] = "StarBook",
    ["device.description"] = "StarBook",
    ["device.nick"] = "StarBook",
    ["device.product.name"] = "StarBook",
  },
}

table.insert(alsa_monitor.rules, rule_starbook)

rule_starbook_hdmi = {
  matches = {
    {
      { "node.name", "matches", "alsa_output.pci-0000_03_00.1.pro-output-3" },
      { "node.name", "matches", "alsa_output.pci-0000_03_00.1.pro-output-7" },
      { "node.name", "matches", "alsa_output.pci-0000_03_00.1.hdmi-surround" },
      { "node.name", "matches", "alsa_output.pci-0000_03_00.1.hdmi-surround71" },
      { "node.name", "matches", "alsa_output.pci-0000_03_00.1.hdmi-stereo-extra1" },
      { "node.name", "matches", "alsa_output.pci-0000_03_00.1.hdmi-stereo" },
    },
  },
  apply_properties = {
    ["node.description"] = "HDMI",
    ["node.nick"] = "HDMI",
    ["device.description"] = "HDMI",
    ["device.nick"] = "HDMI",
    ["device.product.name"] = "HDMI",
  },
}

table.insert(alsa_monitor.rules, rule_starbook_hdmi)

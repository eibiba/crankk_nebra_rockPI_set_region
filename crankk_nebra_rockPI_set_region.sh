#!/bin/sh
# crankk_nebra_rockPI_set_region.sh
# --------------------------
#
# author: pedro.marques@eibiba.com
#
# At this date (2023-05-02), Nebra RockPI Indoor gateways may have trouble to assert it's location. This issue makes the packet forwarder to restart constantly, not allowing the gateway to work properly on Cra# This script sets the region on the gateway configuration, allowing the packet forwarder to work properly.
#
# Right now, only EU868 and US915 regions are supported. If the issue persists and new regions became available, they will be added.
#
# Usage: ./crankk_nebra_rockPI_set_region.sh
#
# This script must be executed on the gateway system.
#
#
containerID=`balena ps | grep helium-miner | awk '{print $1}'`
if [ -z $containerID ]; then
   echo "Helium Gateway container not found. Abort."
   exit 1
else
   freq=
   labelselect="Select the frequency band: "
   select opt in EU868 US915; do                                                                                                                                                                                    case $opt in                                                                                                                                                                                                        EU868)
         freq=$opt                                                                                                                                                                                                        break                                                                                                                                                                                                            ;;
      US915)
         freq=$opt
         break
         ;;
      *)
         echo "Invalid option $REPLY"
         ;;
      esac
   done
   epoch=`date +%s`
   balena exec -it $containerID sh -c "cp /etc/helium_gateway/settings.toml /etc/helium_gateway/settings.toml.bck.$epoch" &>/dev/null
   balena exec -it $containerID sh -c "sed -i 's/^region = \"EU868\".*//i ' /etc/helium_gateway/settings.toml" &>/dev/null
   balena exec -it $containerID sh -c "sed -i 's/^region = \"US915\".*//i ' /etc/helium_gateway/settings.toml" &>/dev/null
   balena exec -it $containerID sh -c "sed -i '/^# region = \"US915\".*/a region = \"$opt\"' /etc/helium_gateway/settings.toml" &>/dev/null
   echo $'\n'Done. Reboot gateway to apply changes.
fi

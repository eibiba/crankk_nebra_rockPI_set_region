# crankk_nebra_rockPI_set_region

At this date (2023-05-02), Nebra RockPI Indoor gateways may have trouble to assert it's location. 

This issue makes the packet forwarder to restart constantly, not allowing the gateway to work properly on Crankk network.

This script sets the region on the gateway configuration, allowing the packet forwarder to work properly.

Right now, only EU868 and US915 regions are supported. If the issue persists and new regions became available, they will be added.

Usage: ./crankk_nebra_rockPI_set_region.sh

This script must be executed on the gateway system.

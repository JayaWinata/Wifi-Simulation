package jaringan_nirkabel_2.simulations;

@license(LGPL);

import inet.common.scenario.ScenarioManager;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.ethernet.Eth100M;
import inet.node.inet.StandardHost;
import inet.node.inet.WirelessHost;
import inet.node.wireless.AccessPoint;
import inet.physicallayer.wireless.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
import inet.visualizer.common.IntegratedVisualizer;
import inet.visualizer.contract.IIntegratedVisualizer;
import inet.environment.common.PhysicalEnvironment;
import inet.node.contract.INetworkNode;



network SmartHomeNetwork
{
    parameters:
		@display("bgb=600,400");
        @figure[title](type=label; pos=0,-1; anchor=sw; color=darkblue);
        
        // Throughput
        @statistic[throughput](source="throughput(packetSentToUpper)"; record=vector);
        
        // Packet Loss
        @statistic[packetSent](source="packetSent"; record=count);
		@statistic[packetReceived](source="packetReceived"; record=count);
		@statistic[packetDrop](source="packetDrop"; record=count);

        
        // End-to-End Delay (Latency)
        @statistic[endToEndDelay](source="endToEndDelay(packetReceived)"; record=vector);

    submodules:
        visualizer: <default(firstAvailableOrEmpty("IntegratedCanvasVisualizer"))> like IIntegratedVisualizer if typename != "" {
            @display("p=50,50");
        }
        radioMedium: Ieee80211ScalarRadioMedium {
            @display("p=50,104");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=50,165");
            config = xml("<config><interface hosts='*' address='10.0.0.x' netmask='255.255.255.0'/></config>");
        }
        scenarioManager: ScenarioManager {
            @display("p=50,225");
        }
        accessPoint: AccessPoint {
            @display("p=300,200");
        }
        smartLight1: <default("WirelessHost")> like INetworkNode {
            @display("p=172,147");
        }
        smartLight2: <default("WirelessHost")> like INetworkNode {
            @display("p=461,291");
        }
        securityCamera1: <default("WirelessHost")> like INetworkNode {
            @display("p=476,92");
        }
        securityCamera2: <default("WirelessHost")> like INetworkNode {
            @display("p=211,281");
        }
        doorLock: <default("WirelessHost")> like INetworkNode {
            @display("p=431,201");
        }
        homeAssistant: <default("WirelessHost")> like INetworkNode {
            @display("p=311,92");
        }
        physicalEnvironment: PhysicalEnvironment {
            @display("p=180,425");
            config = xmldoc("walls.xml");
        }
}

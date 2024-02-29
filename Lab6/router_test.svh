`ifndef INC_ROUTER_TEST_SVH
`define INC_ROUTER_TEST_SVH
`include "Packet.sv"
typedef class Packet;
typedef mailbox #(Packet) pkt_mbox;
`endif

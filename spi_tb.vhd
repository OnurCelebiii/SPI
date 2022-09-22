----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.09.2022 10:10:43
-- Design Name: 
-- Module Name: spi_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity spi_tb is
end spi_tb;

architecture Behavioral of spi_tb is

component SPI_Slave is

    Port (i_sck                 :                   in std_logic                        ;
          i_mosi                :                   in std_logic                        ;
          i_ss                  :                   in std_logic                        ;
          i_rst                 :                   in std_logic                        ;       -- asynchronous rst
          o_miso                :                   out std_logic)                      ;
          
end component;

signal tb_i_sck                 :                   std_logic           := '0'          ;
signal tb_i_mosi                :                   std_logic           := '1'          ;
signal tb_i_ss                  :                   std_logic           := '0'          ;
signal tb_i_rst                 :                   std_logic           := '0'          ;
signal tb_o_miso                :                   std_logic                           ;


begin

DUT : SPI_Slave port map (

i_sck        =>       tb_i_sck            ,
i_mosi       =>       tb_i_mosi           ,
i_ss         =>       tb_i_ss             ,
i_rst        =>       tb_i_rst            ,
o_miso       =>       tb_o_miso)          ;


process begin 

    for a in 0 to 1 loop 
    tb_i_sck <= not tb_i_sck;
    wait for 20 ns;
    end loop;

end process;

end Behavioral;

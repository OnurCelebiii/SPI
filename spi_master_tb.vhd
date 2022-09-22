----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.09.2022 11:12:39
-- Design Name: 
-- Module Name: spi_master_tb - Behavioral
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

entity spi_master_tb is
end spi_master_tb;

architecture Behavioral of spi_master_tb is

component SPI_Master is

    Port (
    i_data              :                   in std_logic_vector (7 downto 0)     ;
    i_sck               :                   in std_logic                         ;
    i_miso              :                   in std_logic                         ;
    i_ss                :                   in std_logic                         ;
    i_rst               :                   in std_logic                         ;
    o_mosi              :                   out std_logic)                       ;

end component;

signal tb_i_data         :                   std_logic_vector (7 downto 0)   := x"FF"     ;
signal tb_i_sck          :                   std_logic                       := '0'       ;
signal tb_i_miso         :                   std_logic                       :='1'        ;
signal tb_i_ss           :                   std_logic                       := '0'       ;
signal tb_i_rst          :                   std_logic                       := '0'       ;
signal tb_o_mosi         :                   std_logic                                    ;

begin

DUT : SPI_Master port map(

i_data                   =>                  tb_i_data                            ,
i_sck                    =>                  tb_i_sck                             ,
i_miso                   =>                  tb_i_miso                            ,
i_ss                     =>                  tb_i_ss                              ,
i_rst                    =>                  tb_i_rst                             ,
o_mosi                   =>                  tb_o_mosi)                           ;


process begin

    for a in 0 to 1 loop
    
        tb_i_sck <= not tb_i_sck    ;
        wait for 20 ns              ;
    
    end loop;

end process;

end Behavioral;
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.09.2022 11:28:47
-- Design Name: 
-- Module Name: spi_top_module_tb - Behavioral
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

entity spi_top_module_tb is
end spi_top_module_tb;

architecture Behavioral of spi_top_module_tb is

component SPI_Top_Module is

    Port (i_data                    :           in std_logic_vector(7 downto 0)     ;
          i_sck                     :           in std_logic                        ;
          i_ss                      :           in std_logic                        ;
          i_rst                     :           in std_logic)                       ;
          
end component;

signal tb_i_data                    :           std_logic_vector(7 downto 0)   := "10101010"     ;   
signal tb_i_sck                     :           std_logic                      := '0'            ;   
signal tb_i_ss                      :           std_logic                      := '0'            ;   
signal tb_i_rst                     :           std_logic                      := '0'            ;   

begin

DUT :SPI_Top_Module  port map (
i_data          =>              tb_i_data          ,
i_sck           =>              tb_i_sck           ,
i_ss            =>              tb_i_ss            ,
i_rst           =>              tb_i_rst)          ;

process begin 

    for a in 0 to 1 loop 
    
        tb_i_sck <= not tb_i_sck;
        wait for 20 ns;
    
    end loop;


end process;

end Behavioral;

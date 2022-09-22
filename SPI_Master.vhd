----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.09.2022 10:55:02
-- Design Name: 
-- Module Name: SPI_Master - Behavioral
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

entity SPI_Master is

    Port (
    i_data              :                   in std_logic_vector (7 downto 0)     ;
    i_sck               :                   in std_logic                         ;
    i_miso              :                   in std_logic                         ;
    i_ss                :                   in std_logic                         ;
    i_rst               :                   in std_logic                         ;
    o_mosi              :                   out std_logic)                       ;

end SPI_Master;

architecture Behavioral of SPI_Master is

type   ss                       is                  (idle   ,  send)                    ;
signal state                    :                   ss                                  ;
signal s_i_data                 :                   std_logic_vector (7 downto 0)       ;
signal s_o_mosi                 :                   std_logic                           ;
signal s_i_ss                   :                   std_logic                           ;
signal s_i_miso                 :                   std_logic                           ;
signal s_o_mosi_reg             :                   std_logic_vector(7 downto 0)        ;
signal s_i_miso_reg             :                   std_logic_vector(7 downto 0)        ;
signal clk_counter              :                   integer range 0 to 105 := 0         ;
signal clk_control              :                   integer := 104                      ;
signal i                        :                   integer := 0                        ;


begin

process (i_sck) begin

 o_mosi                 <=          s_o_mosi              ;
 s_i_ss                 <=          i_ss                  ;
 s_i_miso               <=          i_miso                ;
 s_i_data               <=          i_data                ;
 
 
if rising_edge(i_sck)then 

    if i_rst = '1' then
    
        s_i_ss              <=          '1'                   ;
        s_i_miso            <=          '1'                   ;
        s_o_mosi_reg        <=          x"00"                 ;
        clk_counter         <=          0                     ;
        state               <=          idle                  ;    
    
    else
    
        case state is
            
            when idle =>  if i_ss = '1' then 
            
                              s_o_mosi                  <=          '1'                      ;
                              s_i_miso                  <=          '1'                      ;
                              state                     <=          idle                     ;
                              clk_counter               <=          0                        ;
                          else 
                          
                              state                     <=          send                     ;
                              s_o_mosi_reg              <=          x"00"                    ;
                              s_o_mosi                  <=          '0'                      ;
                              s_i_miso                  <=          '0'                      ;
                              
                          end if;
                          
            when send =>  if i_ss = '0' then 
            
                              if clk_counter >= clk_control then 
                               
                                  if i < 7 then
                            
                                      i                  <=          i + 1                    ;
                                      clk_counter        <=          0                        ;
                                        
                                  else
                                  
                                      s_o_mosi_reg       <=          x"00"                    ;
                                      s_i_miso_reg       <=          x"00"                    ;
                                      clk_counter        <=          0                        ;
                                      i                  <=          0                        ;
                                      state              <=          send                     ;
                                    
                                      
                                  end if;
                                   
                              else 
                                 
                                  clk_counter            <=          clk_counter + 1          ;
                                  s_o_mosi               <=          s_i_data(i)              ;
                                  s_i_miso_reg(i)        <=          s_i_miso                 ;   
                                                       
                              end if;
                               
                          else
                              s_o_mosi_reg               <=          x"00"                    ;
                              s_i_miso_reg               <=          x"00"                    ;   
                              i                          <=          0                        ;
                              clk_counter                <=          0                        ;                   
                              state                      <=          idle                     ;
                          end if;
            
        end case;
    end if;
end if;


end process;
end Behavioral;

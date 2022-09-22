----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.09.2022 08:53:18
-- Design Name: 
-- Module Name: SPI_Slave - Behavioral
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


entity SPI_Slave is

    Port (i_sck                 :                   in std_logic                        ;
          i_mosi                :                   in std_logic                        ;
          i_ss                  :                   in std_logic                        ;
          i_rst                 :                   in std_logic                        ;       -- asynchronous rst
          o_miso                :                   out std_logic)                      ;
          
end SPI_Slave;

architecture Behavioral of SPI_Slave is

type   ss                       is                  (idle   ,  data)                    ;
signal state                    :                   ss                                  ;
signal s_i_mosi                 :                   std_logic                           ;
signal s_i_ss                   :                   std_logic                           ;
signal s_o_miso                 :                   std_logic                           ;
signal s_i_mosi_reg             :                   std_logic_vector(7 downto 0)        ;
signal s_o_miso_reg             :                   std_logic_vector(7 downto 0)        ;
signal clk_counter              :                   integer range 0 to 105 := 0         ;
signal clk_control              :                   integer := 104                      ;
signal i                        :                   integer := 0                        ;

begin


process (i_sck) begin

 s_i_mosi               <=          i_mosi                ;
 s_i_ss                 <=          i_ss                  ;
 o_miso                 <=          s_o_miso              ;


if rising_edge(i_sck)then 
    if i_rst = '1' then
    
    s_i_ss              <=          '1'                   ;
    s_o_miso            <=          '1'                   ;
    s_i_mosi_reg        <=          x"00"                 ;
    clk_counter         <=          0                     ;
    state               <=          idle                  ;    
    
    else
    
        case state is
            
            when idle =>  if i_ss = '1' then 
            
                              s_i_mosi                  <=          '1'                      ;
                              s_o_miso                  <=          '1'                      ;
                              state                     <=          idle                     ;
                              clk_counter               <=          0                        ;
                          else 
                          
                              state                     <=          data                     ;
                              s_i_mosi_reg              <=          x"00"                    ;
                              s_i_mosi                  <=          '0'                      ;
                              s_o_miso                  <=          '0'                      ;
                              
                          end if;
                          
            when data =>  if i_ss = '0' then 
            
                              if clk_counter >= clk_control then 
                               
                                  if i < 7 then
                            
                                      i                  <=          i + 1                    ;
                                      clk_counter        <=          0                        ;
                                        
                                  else
                                  
                                      s_i_mosi_reg       <=          x"00"                    ;
                                      s_o_miso_reg       <=          x"00"                    ;
                                      clk_counter        <=          0                        ;
                                      i                  <=          0                        ;
                                      state              <=          data                     ;
                                    
                                      
                                  end if;
                                   
                              else 
                                 
                                  clk_counter            <=          clk_counter + 1          ;
                                  s_i_mosi_reg (i)       <=          s_i_mosi                 ;
                                  s_o_miso               <=          s_i_mosi_reg(i)          ;
                                  s_o_miso_reg(i)        <=          s_o_miso                 ;
                                                       
                              end if;
                               
                          else
                              s_i_mosi_reg               <=          x"00"                    ;
                              s_o_miso_reg               <=          x"00"                    ;                      
                              state                      <=          idle                     ;
                          end if;
            
        end case;
    end if;
end if;

end process;

end Behavioral;

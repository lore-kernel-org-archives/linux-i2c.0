From: Michael Lawnick <nospam_lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: Request for Clarification: old - legacy - new driver model
Date: Tue, 24 Feb 2009 16:09:33 +0100
Message-ID: <go12jd$ec4$1@ger.gmane.org>
References: <gngvea$eqj$1@ger.gmane.org>	<20090218173645.GD3049@pengutronix.de>	<gnjplc$hqd$1@ger.gmane.org> <20090220135300.353cd53a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090220135300.353cd53a-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare said the following:
> On Thu, 19 Feb 2009 15:17:13 +0100, Michael Lawnick wrote:
<snip>
>> Our situation: main board is up and running, all drivers loaded.
>> Now an extension board will be plugged in. It is detected by
>> periodically polling via I2C for MUX. After detection the drivers e.g.
> 
> This is totally unsupported. I2C isn't an hot-pluggable bus.
> 
<snip>
> 
> What you are missing, as far as I can see, is proper mux support.
> Rodolfo Giometti (Cc'd) is working on this, if you want to test his
> patches (which I still didn't have the time to look at, sadly.)
> 
I have seen the patches, I am planning based on them.

Well, thinking about it, I hope to have a solution.
Here is what a H/W might look like:
                          +-------+   +--------+
                          |  LM75 |   | EEPROM |
                          +-------+   +--------+
 Mainboard                    |           |
+------------+                |           |
| controller |----------------+-----+-----+---....
+------------+                      |
                                    |
                                    |
                                 +------+
                                 |      |
   ...>--------------------------| MUX1 |----------------------<...
               +-----------------|      |---------------+
               |                 +------+               |
               |                                        |
               |                                        |
               ^                                        ^
Plugin1        |                          Plugin2       |
            +------+                                +------+
            |      |   +-------+                    |      |   +-------+
        +---| MUX2 |---|  LM75 |                +---| MUX3 |---|  LM75 |
        |   |      |   +-------+                |   |      |   +-------+
        |   +------+                            |   +------+
        |                                       |
        |   +-------+                           |   +-------+
        +---|  LM75 |                           +---|  LM75 |
        |   +-------+                           |   +-------+
        |                                       |
        |   +--------+                          |   +--------+
        +---| EEPROM |                          +---| EEPROM |
        |   +--------+                          |   +--------+
        |                                       |


The idea: when deferring the instantiation of the adapters of MUX1,
there should be something like a hot-plug event.
AFAIK, after adding an adapter via i2c_add_numbered_adapter(), the I2C
subsystem will probe for all currently known clients on this new bus.
Correct?
If so, this should cascade through the newly plugged in board.

This defer could be implemented by removing auto instantiation (module
parameter) but adding a sysFs entry on MUX that does it on demand:
#start controller 5
echo 5 > /sys/bus/i2c/devices/1-0020/startAdapter
#stop controller 5
echo 5 > /sys/bus/i2c/devices/1-0020/stopAdapter

Any contradictions?

-- 
Regards,
Michael

From: NiTr0 <nitr0-z9XQkeP78BxUq1AO9QMCaQ@public.gmane.org>
Subject: i2c_smbus_write_block_data vs scheduled routine calls (add_timer)
 - kernel crash
Date: Tue, 04 Aug 2009 21:42:41 +0300
Message-ID: <4A788121.8020601@seti.kr.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

I tried to improve voltage/FSB manipulation module for EeePC 
(http://code.google.com/p/eeepc-linux) - and I found that 
i2c_smbus_write_block_data will cause kernel panic when is called from 
function called by timer. I can't see kernel panic message because 
system print very long call trace. Also on EeePC there is no RS232 port 
- but I have USB->RS232 dongle, can it be used as terminal for debug 
messages?

All variables are declared as static, all data is prepared correctly - 
so IMHO trouble is outside of my driver.
There is a part of code:

static struct i2c_client eee_pll_smbus_client = {
        .adapter = NULL,
        .addr = 0x69,
        .flags = 0,
};
static char eee_pll_data[I2C_SMBUS_BLOCK_MAX];
static int eee_pll_datalen = 0;
.......................
        i2c_smbus_write_block_data(&eee_pll_smbus_client,0, 
eee_pll_datalen, eee_pll_data);

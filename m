From: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c-pxa.c: timeouts off by 1
Date: Thu, 23 Apr 2009 16:27:39 +0200
Message-ID: <49F07ADB.1030300@gmail.com>
References: <49A524E4.5050108@gmail.com> <20090423143654.7fc2327e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090423143654.7fc2327e-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Jean Delvare wrote:
> Hi Roel,
> 
> Sorry for the late reply, I overlooked your patch.
> 
> On Wed, 25 Feb 2009 12:00:52 +0100, Roel Kluin wrote:
>> with while (timeout++ < MAX_TIMEOUT); timeout reaches MAX_TIMEOUT + 1 after the
>> loop, so the tests below are off by one.
> 
> This is correct. It just shows how all PC SMBus master drivers have
> been copied from each other ;)

>> --- a/drivers/i2c/busses/i2c-pxa.c
>> +++ b/drivers/i2c/busses/i2c-pxa.c
>> @@ -264,10 +264,10 @@ static int i2c_pxa_wait_bus_not_busy(struct pxa_i2c *i2c)
>>  		show_state(i2c);
>>  	}
>>  
>> -	if (timeout <= 0)
>> +	if (timeout < 0)
>>  		show_state(i2c);
>>  
>> -	return timeout <= 0 ? I2C_RETRY : 0;
>> +	return timeout < 0 ? I2C_RETRY : 0;
>>  }
>>  
> 
> This one is different and doesn't match the description. I'm excluding
> it from this patch, for this reason and also because there may be other
> i2c-pxa patches pending on the arm side. Can you please submit a
> separate patch for i2c-pxa? Thanks.

Ok, here's for drivers/i2c/busses/i2c-pxa.c. Note that I found another,
the last hunk.
--------------------------->8-------------8<------------------------------
With `while (timeout--)' timeout reaches -1 after the loop, so the tests
below are off by one.

Signed-off-by: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index c1405c8..acc7143 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -265,10 +265,10 @@ static int i2c_pxa_wait_bus_not_busy(struct pxa_i2c *i2c)
 		show_state(i2c);
 	}
 
-	if (timeout <= 0)
+	if (timeout < 0)
 		show_state(i2c);
 
-	return timeout <= 0 ? I2C_RETRY : 0;
+	return timeout < 0 ? I2C_RETRY : 0;
 }
 
 static int i2c_pxa_wait_master(struct pxa_i2c *i2c)
@@ -612,7 +612,7 @@ static int i2c_pxa_pio_set_master(struct pxa_i2c *i2c)
 		show_state(i2c);
 	}
 
-	if (timeout <= 0) {
+	if (timeout < 0) {
 		show_state(i2c);
 		dev_err(&i2c->adap.dev,
 			"i2c_pxa: timeout waiting for bus free\n");

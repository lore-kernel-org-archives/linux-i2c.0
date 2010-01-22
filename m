From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: Re: [PATCH 04/11] i2c-mpc: Add MPC5121 I2C bus support
Date: Fri, 22 Jan 2010 13:15:24 +0100
Message-ID: <4B5996DC.1020309@grandegger.com>
References: <1263932653-3634-1-git-send-email-agust@denx.de> 	<1263932653-3634-5-git-send-email-agust@denx.de> <fa686aa41001210912r5fd2a5a4g8a072e0c41ee4107@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <fa686aa41001210912r5fd2a5a4g8a072e0c41ee4107-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>, wd-ynQEQJNshbs@public.gmane.org, dzu-ynQEQJNshbs@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Piotr Ziecik <kosmo-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Grant Likely wrote:
> On Tue, Jan 19, 2010 at 1:24 PM, Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org> wrote:
>> From: Piotr Ziecik <kosmo-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
>>
>>    - Update Kconfig for i2c-mpc driver.
>>    - Enable I2C interrupts on MPC5121.
>>
>> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
>> index f627001..84eeb25 100644
>> --- a/drivers/i2c/busses/i2c-mpc.c
>> +++ b/drivers/i2c/busses/i2c-mpc.c
>> @@ -540,6 +540,29 @@ static int __devinit fsl_i2c_probe(struct of_device *op,
>>                }
>>        }
>>
>> +       if (of_device_is_compatible(op->node, "fsl,mpc5121-i2c")) {
> 
> Rather than doing stuff like this with explicit compatible checks in
> the probe hook, consider using the .data pointer in the of match
> table.

Yes, and it does also not use the clock setting code of the MPC5200,
which should work for the MPC512x as well. I already have a patch in my
pipeline, which I will roll out after some more testing.

Wolfgang.

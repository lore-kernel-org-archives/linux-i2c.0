From: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v3 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
Date: Fri, 16 Jan 2015 14:51:12 -0800
Message-ID: <54B995E0.8090406@broadcom.com>
References: <rjui@broadcom.com> <1418183832-24793-1-git-send-email-rjui@broadcom.com> <1418183832-24793-3-git-send-email-rjui@broadcom.com> <20150113225012.GK22880@pengutronix.de> <54B5D0F9.8030902@broadcom.com> <20150115115957.GA2549@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150115115957.GA2549@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: =?windows-1252?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



On 1/15/2015 3:59 AM, Wolfram Sang wrote:
>>>> +	case M_CMD_STATUS_LOST_ARB:
>>>> +		dev_err(dev->device, "lost bus arbitration\n");
>>> I wouldn't dev_err that, only dev_dbg. I'm not sure how usual the errors
>>> for the next two cases is, maybe degrade them to dev_dbg, too?
>>>
>> These errors are rare, and it's nice to keep them at the dev_err level
>> so the user will be more aware.
> 
> This is wrong. Arbitration lost and NACK is pretty standard stuff on an
> I2C bus. User doesn't need to know about it, it is just noise in the
> logs. Timeout is different, you can report that (although I should
> probably move such a message into the core). Please also use the proper
> errno codes defined in Documentation/i2c/fault-codes. They should be
> distinct enough to drop the messages.
> 
Okay will do.

>>
>>>> +		return -EREMOTEIO;
>>>> +
>>>> +	case M_CMD_STATUS_NACK_ADDR:
>>>> +		dev_err(dev->device, "NAK addr:0x%02x\n", dev->msg->addr);
>>>> +		return -EREMOTEIO;
>>>> +
>>>> +	case M_CMD_STATUS_NACK_DATA:
>>>> +		dev_err(dev->device, "NAK data\n");
>>>> +		return -EREMOTEIO;
>>>> +
>>>> +	case M_CMD_STATUS_TIMEOUT:
>>>> +		dev_err(dev->device, "bus timeout\n");
>>>> +		return -ETIMEDOUT;
>>>> +
>>>> +	default:
>>>> +		dev_err(dev->device, "unknown error code=%d\n", val);
>>>> +		return -EREMOTEIO;
>>>> +	}
>>>> +
>>>> +	return -EREMOTEIO;
>>>> +}

From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 2/2] i2c: mv64xxx: Fix bus hang on A0 version of the
 Armada XP SoCs
Date: Fri, 03 Jan 2014 20:31:57 +0100
Message-ID: <52C7102D.60401@free-electrons.com>
References: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com> <1388743185-24822-3-git-send-email-gregory.clement@free-electrons.com> <20140103194929.706f93c6@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140103194929.706f93c6@skate>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 03/01/2014 19:49, Thomas Petazzoni wrote:
> Dear Gregory CLEMENT,
> 
> On Fri,  3 Jan 2014 10:59:45 +0100, Gregory CLEMENT wrote:
> 
>> +		/*
>> +		 * Only revison more recent than A0 support offload
> 
> revison -> revisions
> 
> offload mechanism -> the offload mechanism
> 
>> +		 * mechanism. In case we can't get the SoC revision
>> +		 * weplay safe and we don't enable it
> 
> weplay -> we play
> 
>> +		 */
>> +		if (mvebu_get_soc_id(&rev, &dev) == 0 && dev > MV78XX0_A0_REV)
>> +			drv_data->offload_enabled = true;
>>  	}
>>  
>>  out:
> 

These typos will be fixed in the next version.

> Thanks!
> 
> Thomas
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

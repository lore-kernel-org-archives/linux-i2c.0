From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 2/3] ARM: mvebu: Add quirk for i2c
Date: Wed, 08 Jan 2014 14:42:45 +0100
Message-ID: <52CD55D5.6020703@free-electrons.com>
References: <1389112504-9931-1-git-send-email-gregory.clement@free-electrons.com> <1389112504-9931-3-git-send-email-gregory.clement@free-electrons.com> <201401081352.57361.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201401081352.57361.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 08/01/2014 13:52, Arnd Bergmann wrote:
> On Tuesday 07 January 2014, Gregory CLEMENT wrote:
> 
>>  static void __init armada_370_xp_dt_init(void)
>>  {
>> +       i2c_quirk();
>>         of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>>  }
> 
> I'd prefer to enable the quirk only on machines that we know may be affected, i.e.
> OpenBlocks AX3-4. That would make it easier in the future for everyone to figure
> out whether they need to include the quirk in their kernels or not, depending
> on whether they want to support these machines. Just a precaution in case we
> end up having lots of quirks in the long run.

You means something like the following code ?

static void __init armada_370_xp_dt_init(void)
 {
+       if (of_machine_is_compatible("plathome,openblocks-ax3-4"))
+               i2c_quirk();
        of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }




> 
> 	Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

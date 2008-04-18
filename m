From: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
Subject: Re: build breakage from of i2c helper patch
Date: Fri, 18 Apr 2008 14:35:29 +0200
Message-ID: <48089591.608@scram.de>
References: <CDDD8C0A-4B40-4CA7-BB84-50B2A93C7804@kernel.crashing.org>	<48071778.2000405@scram.de>
	<18440.34234.28845.7398@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <18440.34234.28845.7398-UYQwCShxghk5kJ7NmlRacFaTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org list" <linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Paul,

> Which way around is this dependency?  Do you mean that the patches you
> listed depend on the "OF helpers for the i2c API" patch, or that the
> OF helpers patch depends on these other ones?

The OF helpers patch depends on the patches below to support autoloading
i2c modules using the alias mechanism. Otherwise, we need to translate
between i2c module type and driver_name in the helper patch (like currently
done in fsl_soc.c function of_find_i2c_driver()). However, this old way
doesn't really scale well.

> 
>> http://patchwork.ozlabs.org/linuxppc/patch?id=17833
>> http://patchwork.ozlabs.org/linuxppc/patch?id=17834
>>
>> or the original ones from Jean Delvare:
>>
>> http://patchwork.ozlabs.org/linuxppc/patch?id=16282
>> http://patchwork.ozlabs.org/linuxppc/patch?id=16283
>> http://patchwork.ozlabs.org/linuxppc/patch?id=16284
> 
> What's the best way to fix this now?  We need to get a reasonable fix
> in before I ask Linux to pull the powerpc tree.

Thanks,
Jochen

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

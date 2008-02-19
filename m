From: Sean MacLennan <smaclennan-Qtffpm9i2AVWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c-ibm_iic driver
Date: Tue, 19 Feb 2008 18:18:06 -0500
Message-ID: <47BB63AE.2090903@pikatech.com>
References: <4784FED1.2040206@pikatech.com><20080219092321.1fed233d@hyperion.delvare><200802190959.41253.sr@denx.de>
	<200802192355.17707.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200802192355.17707.arnd-r2nGTMty4D4@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Arnd Bergmann wrote:
> On Tuesday 19 February 2008, Stefan Roese wrote:
>   
>> On Tuesday 19 February 2008, Jean Delvare wrote:
>>     
>>> With this Kconfig change, "make menuconfig" lets me select the
>>> i2c-ibm_iic driver on x86_64, but it fails to build horribly. I think
>>> that you want to restrict the build to PPC machines somehow, or at
>>> least make sure that either IBM_OCP or OF support is present.
>>>       
>> How about this:
>>
>> -       depends on IBM_OCP
>> +       depends on 4xx
>>     
>
> I think we should allow it to be built on other platforms as well,
> as long as they have of_platform_device support.
>
> The Axon south bridge used on IBMs QS21 blade probably has an ibm_iic,
> even though it's managed by the firmware and we probably don't want
> to use it at this time, someone could use the same chip in a new
> design and actually do that.
>
> In general, I also like to make it possible to enable drivers just
> for the benefit of compile testing, even for stuff that you can't
> find in any existing HW configuration, so as long as it builds on
> a platform, I think we shouldn't forbid it:
>
> -       depends on IBM_OCP
> +       depends on IBM_OCP || PPC_MERGE
>
>   
I have no problem with this change. If everybody agrees, I can respin 
the patch.

Cheers,
   Sean

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

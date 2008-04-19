From: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
Subject: Re: [PATCH] rtc-pcf8563: Add device ids table
Date: Sat, 19 Apr 2008 18:43:03 +0200
Message-ID: <480A2117.7020502@scram.de>
References: <200804171708.32847.laurentp@cse-semaphore.com>	<20080418235451.2643183b@i1501.lan.towertech.it>	<20080419113417.19f5567a@hyperion.delvare>	<4809EF23.7070902@scram.de>
	<20080419162358.746b714c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080419162358.746b714c-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linuxppc-dev list <linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, Alessandro Zummo <alessandro.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare wrote:
> On Sat, 19 Apr 2008 15:09:55 +0200, Jochen Friedrich wrote:
>> Hi Jean,
>>
>>>>> Is the new-style driver conversion patch in 2.6.25-rc8-mm2 scheduled for
>>>>> 2.6.26 ?
>>>>  hope so! :)
>>> Note that this patch depends on i2c patches which aren't upstream yet.
>> Is there any chance they will got to 2.6.26?
> 
> I'm not sure. I didn't have the time to look at it myself, but I am
> under the impression that the powerpc folks are tired of having to wait
> for me and may push it to Linus through their tree? That would be fine
> with me, as I don't want to be the one delaying something many
> developers want (but I also can't sign patches I've not even read.)

The required patches are:

http://patchwork.ozlabs.org/linuxppc/patch?id=17833
http://patchwork.ozlabs.org/linuxppc/patch?id=17834

which are just the forward ported patches you sent to the poweprc mailing list some time ago:

http://patchwork.ozlabs.org/linuxppc/patch?id=16282
http://patchwork.ozlabs.org/linuxppc/patch?id=16283

Thanks,
Jochen

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: [PATCH] I2C: ISP1301: Sync with linux-omap
Date: Sun, 16 Mar 2008 13:18:26 -0500
Message-ID: <9044606ee51aca6bd6d6b04212c9ed6b@felipebalbi.com>
References: <200803161059.52278.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200803161059.52278.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



On Sun, 16 Mar 2008 09:59:51 -0800, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
wrote:
> On Sunday 16 March 2008, Felipe Balbi wrote:
>> There are some changes on linux-omap's isp1301_omap.c
>> that could already be in linux-mainline after
>> omap1/2 got merged.
>>
>> This patch sync such changes from linux-omap into linux-mailine.
> 
> Did you re-test this on H2?
> 
> The reason the state machine changes haven't gone upstream
> is because, last I checked, they broke OTG on H2 ... the
> controller on H3 had some incompatible changes.

Like i told you before,  dont have access to h2 anymore.
only omap3 :s

if you could try whenever you have time... otherwise ill revert

> 
> - Dave
-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

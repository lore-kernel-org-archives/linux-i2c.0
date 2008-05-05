From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: Match dummy devices by type
Date: Mon, 5 May 2008 18:43:19 +0200
Message-ID: <20080505184319.462b0ce6@hyperion.delvare>
References: <20080505112858.5101c99a@hyperion.delvare>
	<200805050833.55242.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200805050833.55242.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 5 May 2008 08:33:54 -0700, David Brownell wrote:
> On Monday 05 May 2008, Jean Delvare wrote:
> > little reason to use these i2c clients to log messages.
> 
> I'd assume the opposite, actually.  Any i2c_client should
> be sensible to use for message logging.

I'd expect drivers to use the main i2c_client for that. i2c-core may
still use the dummy clients for debug messages, but it probably doesn't
matter. And nothing will break, the logs with just have "dummy" as the
client name.

At the moment, I can't foresee any problem important enough to require
improving the situation - especially since I have no clear idea what I
would do anyway. But if you can think of potential problems and you can
propose a solution, I'm listening of course :)

> > +MODULE_DEVICE_TABLE(i2c, dummy_id);
> 
> Strike that.  There's no reason to export this, is there?
> The only dummy devices are the ones drivers which tell th
> core about.  We wouldn't *want* to try hotplugging them.

Totally correct, thanks for pointing this out. I thought I had already
removed it, but obviously not. Fixed.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

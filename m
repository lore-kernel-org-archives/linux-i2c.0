From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] New VID/PID pair for i2c-tiny-usb
Date: Sun, 30 Mar 2008 14:31:07 +0200
Message-ID: <20080330143107.1575e1bf@hyperion.delvare>
References: <200803241042.31263.lists@harbaum.org>
	<20080326154415.2981961a@hyperion.delvare>
	<200803272047.21505.lists@harbaum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200803272047.21505.lists-RcHadlBFbzVAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Till Harbaum / Lists <lists-RcHadlBFbzVAfugRpC6u6w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Till,

On Thu, 27 Mar 2008 20:47:21 +0100, Till Harbaum / Lists wrote:
> Am Mittwoch 26 M=E4rz 2008 schrieb Jean Delvare:
> > Note: your e-mail client is wrapping long lines -> patch doesn't apply.
> I thought i've verified that, but obviously it happened anyway.
> =

> > Please use a single /* */ pair for multi-line comments.
> Ok
> =

> > Maybe I'm missing something obvious, but if you already have a device
> > ID, what's the point of switching to another? The original ID is not
> > going to be deprecated and/or used for something else, is it?
> The original id was donated by ftdi without stating anywhere that the id =
has =

> to be used with their products. So i used it for the i2c-tiny-usb which =

> obviously isn't based on a ftdi chipset. I've been told that ftdi has cha=
nged =

> that policy lately. While i don't expect them to actually ask me not to u=
se =

> their id without using the chips i thought it was clever to switch to an =
id =

> i've explicitely bought to avoid future problems with ftdis new policies. =

> I'll change the id from the ftdi ones to the ones i recently bought on al=
l my =

> projects. Just to avoid future problems as early as possible.
> =

> Does this make sense?

Yes it does, thanks for clarifying. Please send an updated patch and
I'll apply it.

> Updated patch will follow.

Do you plan to phase out the old VID/PID pair? If so, I'll have to send
you back my i2c-tiny-usb device for a firmware update.

-- =

Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

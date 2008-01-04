From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/2] Add support for the S-35390A RTC chip.
Date: Fri, 4 Jan 2008 13:42:05 -0800
Message-ID: <200801041342.05612.david-b@pacbell.net>
References: <1197751376-9767-1-git-send-email-byron.bbradley@gmail.com>
	<1197751376-9767-2-git-send-email-byron.bbradley@gmail.com>
	<20080104210605.05e1a0d4@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080104210605.05e1a0d4-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
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
Cc: a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, repvik-ifZ3rLY3rVnQT0dZR+AlfA@public.gmane.org, hvr-mXXj517/zsQ@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, timtimred-f/KTTADhmRsdnm+yROfE0A@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Friday 04 January 2008, Jean Delvare wrote:
> > +=A0=A0=A0=A0=A0if (buf[0] & S35390A_FLAG_24H)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0s35390a->twentyfourhour =3D 1;
> > +=A0=A0=A0=A0=A0else
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0s35390a->twentyfourhour =3D 0;
> =

> Wouldn't it be more efficient to just force 24h mode here?

Maybe, but that would make trouble on multi-master systems where
the other masters assume this stays initialized.  Also, many
RTCs can't change that mode easily ... so it should be done only
when (re)initializing after e.g. an oscillator failure or loss
of the backup power supply.

- Dave
 =

From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATH 0/3] isp1301 changes
Date: Sat, 15 Mar 2008 19:57:49 -0800
Message-ID: <200803152057.49712.david-b@pacbell.net>
References: <1205585237-21492-1-git-send-email-me@felipebalbi.com>
	<31e679430803150838n6638be05k53800bb74eeb3462@mail.gmail.com>
	<31e679430803150840p334e8d17ncdd1fdc431de8d82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <31e679430803150840p334e8d17ncdd1fdc431de8d82-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Felipe Balbi <felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Saturday 15 March 2008, Felipe Balbi wrote:
> > =A0high. Also, a driver shouldn't be conditional to an architecture. I
> > =A0mean, isp1301 can be used with any arch, not only with omap. So as
> > =A0much as we can make it platform independent as better driver we get.

Actually, *this* driver is specific to OMAP since it's got to
coordinate between an OMAP-specific OTG controller and the
more generic isp1301 chip.  So that's not a concern here.

It would be nice of course to have a clean split between the
isp1301 code and the OTG controller ... but I'm not sure how
useful that would be.  The ISP1301 may have effectively become
a CEA standard (yes?) for external full speed OTG transceivers,
but it's not like there have been a flood of Linux platforms
supporting it.

All the new platforms are going for high speed OTG, not full
speed ...

- Dave




_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

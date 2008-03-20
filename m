From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] I2C: ISP1301: Sync with linux-omap
Date: Thu, 20 Mar 2008 02:39:47 -0700
Message-ID: <200803200239.47880.david-b@pacbell.net>
References: <1205585237-21492-1-git-send-email-me@felipebalbi.com>
	<20080318142337.0f9a2b5b@hyperion.delvare>
	<31e679430803180628h7a4926a2t4e540d9617522e28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <31e679430803180628h7a4926a2t4e540d9617522e28-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Felipe Balbi <felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tuesday 18 March 2008, Felipe Balbi wrote:
> >
> > =A0No. You are just paraphrasing, this doesn't help. I need an explanat=
ion
> > =A0of the _functional_ changes implemented by the patch. I don't care m=
uch
> > =A0that these changes come from the omap tree, I don't know anything ab=
out
> > =A0this tree. What I need to know is why the changes are needed by
> > =A0themselves. What problem(s) does this patch address?
> =

> otherwise the driver won't work on board-h3, simple enough

But the reason those changes were never pushed upstream is that
they were known to break board-h2 !!

I was never keen on merging them into the OMAP tree in the first
place, specifically for that reason ... the original idea was
to merge patches that worked on *both* chip revisions.  Failing
that, to follow up the H3 patches with bugfixes; those fixes
never got submitted.

So for what it's worth, I'll NAK those state machine updates.
On the grounds that they *add* bugs.  H3 doesn't work in the
mainline tree yet, so there's no way such a patch could ever
be viewed as an improving anything whatsoever for mainline.





_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

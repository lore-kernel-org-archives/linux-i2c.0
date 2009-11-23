From: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: [PATCH 07/10] ARM: PNX4008: move i2c suspend/resume callbacks
	into driver
Date: Mon, 23 Nov 2009 21:22:44 +0300
Message-ID: <acd2a5930911231022i60eda84di12799fb4a55faab9@mail.gmail.com>
References: <20091120144422.GA18223@n2100.arm.linux.org.uk>
	<E1NBUkU-0004Pm-Nv@rmk-PC.arm.linux.org.uk>
	<20091121125347.GE7998@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0751528294=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20091121125347.GE7998@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, Kevin Wells <kevin.wells@nxp.com>
List-Id: linux-i2c@vger.kernel.org

--===============0751528294==
Content-Type: multipart/alternative; boundary=0016e6d77eac72cecb04790de966

--0016e6d77eac72cecb04790de966
Content-Type: text/plain; charset=ISO-8859-1

On Sat, Nov 21, 2009 at 3:53 PM, Russell King - ARM Linux <
linux@arm.linux.org.uk> wrote:

> On Fri, Nov 20, 2009 at 10:50:34AM +0000, Russell King - ARM Linux wrote:
> > -static int i2c_pnx_suspend(struct platform_device *pdev, pm_message_t
> state)
> > -{
> > -     int retval = 0;
> > -#ifdef CONFIG_PM
> > -     retval = set_clock_run(pdev);
> > -#endif
>
> BTW, a comment from PNX folk (Vitaly/Kevin) would be appreciated.  Why
> does PNX enable the clock when going into suspend?  Should I assume that
> this should actually be disabling the clock?
>

As far as I recall, at some point there was a function that was taking the
second boolean parameter (enable or disable the clock). So now it is, yes,
not making much sense.


> Also, if Vitaly doesn't have anything to do with PNX4008 anymore, it
> would be a good idea to update the MAINTAINERS file.
>

I'd like to keep maintaining this platform, but it's also up to NXP because
I don't have the actual working hardware now so there's not much I can do.

Vitaly

--0016e6d77eac72cecb04790de966
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Sat, Nov 21, 2009 at 3:53 PM, Russell King - =
ARM Linux <span dir=3D"ltr">&lt;<a href=3D"mailto:linux@arm.linux.org.uk">l=
inux@arm.linux.org.uk</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0=
pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">On Fri, Nov 20, 2009 at 10:50:34AM +0000, Russell King - =
ARM Linux wrote:<br>
&gt; -static int i2c_pnx_suspend(struct platform_device *pdev, pm_message_t=
 state)<br>
&gt; -{<br>
&gt; - =A0 =A0 int retval =3D 0;<br>
&gt; -#ifdef CONFIG_PM<br>
&gt; - =A0 =A0 retval =3D set_clock_run(pdev);<br>
&gt; -#endif<br>
<br>
</div>BTW, a comment from PNX folk (Vitaly/Kevin) would be appreciated. =A0=
Why<br>
does PNX enable the clock when going into suspend? =A0Should I assume that<=
br>
this should actually be disabling the clock?<br></blockquote><div><br>As fa=
r as I recall, at some point there was a function that was taking the secon=
d boolean parameter (enable or disable the clock). So now it is, yes, not m=
aking much sense.<br>
<br></div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
Also, if Vitaly doesn&#39;t have anything to do with PNX4008 anymore, it<br=
>
would be a good idea to update the MAINTAINERS file.<br>
</blockquote></div><br>I&#39;d like to keep maintaining this platform, but =
it&#39;s also up to NXP because I don&#39;t have the actual working hardwar=
e now so there&#39;s not much I can do.<br><br>Vitaly<br>

--0016e6d77eac72cecb04790de966--


--===============0751528294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0751528294==--

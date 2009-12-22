From: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: [PATCH 7/10] ARM: PNX4008: move i2c suspend/resume callbacks into
	driver
Date: Tue, 22 Dec 2009 09:51:50 +0300
Message-ID: <acd2a5930912212251u38c5ef82i7c6ed2a97098c3b0@mail.gmail.com>
References: <083DF309106F364B939360100EC290F804F592E907@eu1rdcrdc1wx030.exi.nxp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0026794943=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <083DF309106F364B939360100EC290F804F592E907@eu1rdcrdc1wx030.exi.nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Wells <kevin.wells@nxp.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

--===============0026794943==
Content-Type: multipart/alternative; boundary=001485f6ccf8f92b39047b4ba3bb

--001485f6ccf8f92b39047b4ba3bb
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Dec 22, 2009 at 2:22 AM, Kevin Wells <kevin.wells@nxp.com> wrote:

>
> Signed-off-by: Kevin Wells <kevin.wells@nxp.com>
>

Acked-by: Vitaly Wool <vitalywool@gmail.com>

---
>  arch/arm/mach-pnx4008/i2c.c  |   24 ------------------------
>  drivers/i2c/busses/i2c-pnx.c |    9 +++++++--
>  include/linux/i2c-pnx.h      |    4 ----
>  3 files changed, 7 insertions(+), 30 deletions(-)
>

--001485f6ccf8f92b39047b4ba3bb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Tue, Dec 22, 2009 at 2:22 AM, Kevin W=
ells <span dir=3D"ltr">&lt;<a href=3D"mailto:kevin.wells@nxp.com">kevin.wel=
ls@nxp.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">
<br>
Signed-off-by: Kevin Wells &lt;<a href=3D"mailto:kevin.wells@nxp.com">kevin=
.wells@nxp.com</a>&gt;<br>
</blockquote><div><br>Acked-by: Vitaly Wool &lt;<a href=3D"mailto:vitalywoo=
l@gmail.com">vitalywool@gmail.com</a>&gt; <br><br></div><blockquote class=
=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin=
: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
---<br>
=A0arch/arm/mach-pnx4008/i2c.c =A0| =A0 24 ------------------------<br>
=A0drivers/i2c/busses/i2c-pnx.c | =A0 =A09 +++++++--<br>
=A0include/linux/i2c-pnx.h =A0 =A0 =A0| =A0 =A04 ----<br>
=A03 files changed, 7 insertions(+), 30 deletions(-)<br></blockquote></div>=
<br>

--001485f6ccf8f92b39047b4ba3bb--


--===============0026794943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0026794943==--

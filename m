From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v6] i2c-gpio: add devicetree support
Date: Thu, 24 Feb 2011 19:07:44 -0700
Message-ID: <AANLkTi=5vc_gb1JJ4HSr84GdR_Hzu3ZrAA_ROiVX84pU@mail.gmail.com>
References: <20110223011232.GC15795@trinity.fluff.org>
	<1298520013-3630-1-git-send-email-thomas@wytron.com.tw>
	<20110224162210.GC17735@angua.secretlab.ca>
	<4D670E4B.6000407@wytron.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4379573937144313992=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <4D670E4B.6000407-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
Cc: nios2-dev-1eJk0qcHJCcaeqlQEoCUNoJY59XmG8rH@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Albert Herranz <albert_herranz-mRCrAkd8dF0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

--===============4379573937144313992==
Content-Type: multipart/alternative; boundary=90e6ba61443eb9c537049d11cb8b

--90e6ba61443eb9c537049d11cb8b
Content-Type: text/plain; charset=ISO-8859-1

Okay.
On Feb 24, 2011 7:04 PM, "Thomas Chou" <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org> wrote:
>
> Hi Grant,
>
>
> On 02/25/2011 12:22 AM, Grant Likely wrote:
>>>
>>> +Required properties:
>>> +- compatible : should be "i2c-gpio".
>>> +- gpios : should specify GPIOs used for SDA and SCL lines, in that
order.
>>> +Optional properties:
>>> +- sda-is-open-drain : present if SDA gpio is open-drain.
>>> +- scl-is-open-drain : present if SCL gpio is open-drain.
>>> +- scl-is-output-only : present if the output driver for SCL cannot be
>>> +       turned off. this will prevent clock stretching from working.
>>> +- speed-hz : SCL frequency.
>>
>>
>> Hi Thomas,
>>
>> One nitpick; I just looked, and other i2c controllers are already
>> using 'clock-frequency' instead of 'speed-hz' for the speed of the
>> bus.  I'd like to see this patch use the same terminology.
>
>
> I studied 'clock-frequency' usage of existing i2c drivers before working
on this patch.
>
> i2c-ibm_iic.c, i2c-mpc.c, i2c-ocores.c : use as bus clock frequency input
to the core.
>
> i2c-cpm.c : use as i2c SCL output frequency.
>
> Most other non-i2c drivers use clock-frequency as bus clock frequency
input, too.
>
> I think the SCL freq usage in i2c-cpm.c is confusing. So I would suggest
we borrow 'speed-hz' from spi subsystem, which means the clock freq output
on the peripheral bus.

Okay.

g.

>
> Best regards,
> Thomas
>

--90e6ba61443eb9c537049d11cb8b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>Okay.<br>
On Feb 24, 2011 7:04 PM, &quot;Thomas Chou&quot; &lt;<a href=3D"mailto:thom=
as-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org">thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi Grant,<br>
&gt;<br>
&gt;<br>
&gt; On 02/25/2011 12:22 AM, Grant Likely wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; +Required properties:<br>
&gt;&gt;&gt; +- compatible : should be &quot;i2c-gpio&quot;.<br>
&gt;&gt;&gt; +- gpios : should specify GPIOs used for SDA and SCL lines, in=
 that order.<br>
&gt;&gt;&gt; +Optional properties:<br>
&gt;&gt;&gt; +- sda-is-open-drain : present if SDA gpio is open-drain.<br>
&gt;&gt;&gt; +- scl-is-open-drain : present if SCL gpio is open-drain.<br>
&gt;&gt;&gt; +- scl-is-output-only : present if the output driver for SCL c=
annot be<br>
&gt;&gt;&gt; + =A0 =A0 =A0 turned off. this will prevent clock stretching f=
rom working.<br>
&gt;&gt;&gt; +- speed-hz : SCL frequency.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Hi Thomas,<br>
&gt;&gt;<br>
&gt;&gt; One nitpick; I just looked, and other i2c controllers are already<=
br>
&gt;&gt; using &#39;clock-frequency&#39; instead of &#39;speed-hz&#39; for =
the speed of the<br>
&gt;&gt; bus. =A0I&#39;d like to see this patch use the same terminology.<b=
r>
&gt;<br>
&gt;<br>
&gt; I studied &#39;clock-frequency&#39; usage of existing i2c drivers befo=
re working on this patch.<br>
&gt;<br>
&gt; i2c-ibm_iic.c, i2c-mpc.c, i2c-ocores.c : use as bus clock frequency in=
put to the core.<br>
&gt;<br>
&gt; i2c-cpm.c : use as i2c SCL output frequency.<br>
&gt;<br>
&gt; Most other non-i2c drivers use clock-frequency as bus clock frequency =
input, too.<br>
&gt;<br>
&gt; I think the SCL freq usage in i2c-cpm.c is confusing. So I would sugge=
st we borrow &#39;speed-hz&#39; from spi subsystem, which means the clock f=
req output on the peripheral bus.</p>
<p>Okay.</p>
<p>g.</p>
<p>&gt;<br>
&gt; Best regards,<br>
&gt; Thomas<br>
&gt;<br>
</p>

--90e6ba61443eb9c537049d11cb8b--

--===============4379573937144313992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============4379573937144313992==--

From: viresh kumar <viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V4 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Wed, 13 Jun 2012 10:03:48 +0100
Message-ID: <CAOh2x=m1XFLpunpTPUW7ozT3cExXNHyLwF7sDy4MxyjuK2uNwQ@mail.gmail.com>
References: <cover.1336124143.git.viresh.kumar@st.com>
	<3484bf49a423bd55daa6a45e68c2c31dce46eb32.1336124143.git.viresh.kumar@st.com>
	<4FB1FE9F.7030700@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FB1FE9F.7030700-qxv4g6HH51o@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org" <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, "ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "ml.lawnick-Mmb7MZpHnFY@public.gmane.org" <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, spear-devel <spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, May 15, 2012 at 7:58 AM, Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org> wro=
te:
> On 5/4/2012 3:10 PM, Viresh KUMAR wrote:
>> Add i2c bus recovery infrastructure to i2c adapters as specified in =
the i2c
>> protocol Rev. 03 section 3.16 titled "Bus clear".
>>
>> http://www.nxp.com/documents/user_manual/UM10204.pdf
>>
>> Sometimes during operation i2c bus hangs and we need to give dummy c=
locks to
>> slave device to start the transfer again. Now we may have capability=
 in the bus
>> controller to generate these clocks or platform may have gpio pins w=
hich can be
>> toggled to generate dummy clocks. This patch supports both.
>>
>> This patch also adds in generic bus recovery routines gpio or scl li=
ne based
>> which can be used by bus controller. In addition controller driver m=
ay provide
>> its own version of the bus recovery routine.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
>> ---
>> =A0Documentation/i2c/bus-recovery | =A0 87 ++++++++++++++++++++++
>> =A0drivers/i2c/i2c-core.c =A0 =A0 =A0 =A0 | =A0160 +++++++++++++++++=
+++++++++++++++++++++++
>> =A0drivers/i2c/i2c-mux.c =A0 =A0 =A0 =A0 =A0| =A0 =A09 ++-
>> =A0include/linux/i2c.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 58 +++++++++++++=
+
>> =A04 files changed, 313 insertions(+), 1 deletions(-)
>> =A0create mode 100644 Documentation/i2c/bus-recovery
>
> Hi Wolfram,
>
> Any inputs on this patch.

Ping.

From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: core: Reduce stack size of
 acpi_i2c_space_handler()
Date: Wed, 13 May 2015 09:58:12 +0300
Message-ID: <20150513065812.GB1490@lahna.fi.intel.com>
References: <1430311477-21759-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1430311477-21759-2-git-send-email-jarkko.nikula@linux.intel.com>
 <20150512190505.GB4449@schokonusskuchen.bad>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150512190505.GB4449-oo5tB6JMkjKRinMKxDlMNPwbnWRJjS81@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, May 12, 2015 at 09:05:05PM +0200, Wolfram Sang wrote:
> On Wed, Apr 29, 2015 at 03:44:37PM +0300, Jarkko Nikula wrote:
> > sizeof(struct i2c_client) is 1088 bytes on a CONFIG_X86_64=3Dy buil=
d and
> > produces following warning when CONFIG_FRAME_WARN is set to 1024:
> >=20
> > drivers/i2c/i2c-core.c: In function =E2=80=98acpi_i2c_space_handler=
=E2=80=99:
> > drivers/i2c/i2c-core.c:367:1: warning: the frame size of 1152 bytes=
 is
> > larger than 1024 bytes [-Wframe-larger-than=3D]
> >=20
> > This is not critical given that kernel stack is 16 kB on x86_64 but=
 lets
> > reduce the stack usage by allocating the struct i2c_client from the=
 heap.
> >=20
> > Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>=20
> Besides it should be squashed with the previous patch, I'm fine with
> this. Mika?

No objections from me,

Acked-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

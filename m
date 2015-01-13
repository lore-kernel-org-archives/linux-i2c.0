From: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] i2c: Mark instantiated device nodes with OF_POPULATE
Date: Tue, 13 Jan 2015 14:08:22 +0200
Message-ID: <D5F10C7A-2678-432D-A8A3-A8A9D7F6525E@konsulko.com>
References: <1421082094-10267-1-git-send-email-pantelis.antoniou@konsulko.com> <20150113120530.GF7660@katana>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150113120530.GF7660@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

> On Jan 13, 2015, at 14:05 , Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>=20
> On Mon, Jan 12, 2015 at 07:01:34PM +0200, Pantelis Antoniou wrote:
>> Mark (and unmark) device nodes with the POPULATE flag as appropriate=
=2E
>> This is required to avoid multi probing when using I2C and device
>> overlays containing a mux.
>>=20
>> Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
>=20
> Looks good. I'd think this is 3.19 material?
>=20

It=E2=80=99s a obvious bug fix.

If you can queue this for 3.19 that=E2=80=99d be great.

Regards

=E2=80=94 Pantelis

From: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] i2c: Mark instantiated device nodes with OF_POPULATE
Date: Thu, 15 Jan 2015 20:32:47 +0200
Message-ID: <5F116C80-232D-4587-ACD1-F99C93262D7A@konsulko.com>
References: <1421339635-16039-1-git-send-email-pantelis.antoniou@konsulko.com> <20150115173529.GB6342@katana>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150115173529.GB6342@katana>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

> On Jan 15, 2015, at 19:35 , Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>=20
> On Thu, Jan 15, 2015 at 06:33:55PM +0200, Pantelis Antoniou wrote:
>> Mark (and unmark) device nodes with the POPULATE flag as appropriate=
=2E
>> This is required to avoid multi probing when using I2C and device
>> overlays containing a mux.
>> This patch is also more careful with the release of the adapter devi=
ce
>> which caused a deadlock with muxes.
>>=20
>> Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
>=20
> Applied to for-current, thanks!
>=20

Just sent an updated patch that doesn=E2=80=99t break the build on !OF;=
 some
OF accessors are not defined then.

Regards

=E2=80=94 Pantelis


--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

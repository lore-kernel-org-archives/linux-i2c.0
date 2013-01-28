From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 4/6] Cosmetics: hex to constants for SMBus commands
Date: Mon, 28 Jan 2013 18:42:33 +0100
Message-ID: <20130128184233.48b19a04@endymion.delvare>
References: <1346204115-30293-1-git-send-email-amaury.decreme@gmail.com>
	<1357305215-17643-1-git-send-email-amaury.decreme@gmail.com>
	<1357305215-17643-5-git-send-email-amaury.decreme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1357305215-17643-5-git-send-email-amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Amaury =?ISO-8859-1?B?RGVjcuptZQ==?= <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: nelson-bExrPSV3DA0@public.gmane.org, mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org, amalysh-S0/GAf8tV78@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri,  4 Jan 2013 14:13:33 +0100, Amaury Decr=EAme wrote:
> This patch replaces hexadecimal values by constants for SMBus command=
s
> and bit masks.
>=20
> Signed-off-by: Amaury Decr=EAme <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-sis630.c |   45 ++++++++++++++++++++++++++---=
---------
>  1 files changed, 31 insertions(+), 14 deletions(-)
> (...)

Good idea, however you missed one occurrence of BYTE_DONE_STS in
sis630_transaction_wait().

--=20
Jean Delvare

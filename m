From: Minkyu Kang <promsoft-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] misc: adds support the FSA9480 USB Switch
Date: Wed, 9 Mar 2011 09:01:17 +0900
Message-ID: <AANLkTikfQGZwXj52ew1Zh9gc+YeLxevivaBocx8_uOz-@mail.gmail.com>
References: <4D75D338.9070801@samsung.com>
	<20110308210227.GA12804@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110308210227.GA12804-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm@linux-foundat>
List-Id: linux-i2c@vger.kernel.org

Dear Dave Jones,

On 9 March 2011 06:02, Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On Tue, Mar 08, 2011 at 03:56:56PM +0900, Minkyu Kang wrote:
>
> =A0> +static DEVICE_ATTR(switch, S_IRUGO | S_IWUGO,
> =A0> + =A0 =A0 =A0 =A0 =A0 =A0fsa9480_show_manualsw, fsa9480_set_manu=
alsw);
>
> This probably shouldn't be world writable if it's writing to hardware=
=2E
>

It can be used in user space.

Thanks
Minkyu Kang
--=20
from. prom.
www.promsoft.net

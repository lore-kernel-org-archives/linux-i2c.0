From: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Subject: Re: Problem with restricted I2C algorithms in kernel 2.6.26!
Date: Thu, 7 Aug 2008 09:01:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0808070851310.10341@shell4.speakeasy.net>
References: <5ab239b10807161233i6c1c4d0we01ea1b8e6ccaa5b@mail.gmail.com>
	<20080807131357.59399ddf@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080807131357.59399ddf-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, "D. Kelly" <user.kernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "mailing list: linux-kernel" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 7 Aug 2008, Jean Delvare wrote:
> > One of the biggest reasons people choose to compile things from
> > cvs/svn/mercurial/etc. is because it gives them access to newer bug
> > fixes and support for things not yet present in the kernel source.  A
> > perfect example, the multiproto dvb driver tree.  Users wanting
> > support for dvb-s2 devices have to compile drivers outside of the
> > kernel because it's simply not available in the kernel and won't be
> > for some time.
>
> So basically you are telling that "thanks" to drivers being maintainers
> in external repositories, bugs are not fixed in the upstream kernel in
> a timely manner, and new features take more time to go there too? That
> must be the reason why kernel developers and users alike don't like
> external repositories in the first place.

Code needs to get testing before it's put in the kernel.  How's that
supposed to happen if it's not made available outside the kernel tree
first?

Why does the kernel build system support building out of tree modules if no
one should do it?

Maybe an option to turn i2c algorithms on could do into the Library
Routines menu.  There are already options for things like the crc routines
here so they can be turned on if an out of tree driver needs them but
nothing in the kernel does.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

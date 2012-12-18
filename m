From: YOSHIFUJI Hideaki <yoshfuji-VfPWfsRibaP+Ru+s062T9g@public.gmane.org>
Subject: Re: [IPv6] crashed when __ip6_del_rt()
Date: Tue, 18 Dec 2012 21:05:07 +0900
Message-ID: <50D05BF3.3070807@linux-ipv6.org>
References: <50CF84A5.7030706@linux-ipv6.org>,<50D04B4B.7060002@linux-ipv6.org>,<BAY173-W1475D04C810BF9A1D71FB8B0310@phx.gbl> <BAY173-W14E9D67B7924486F0518F0B0310@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BAY173-W14E9D67B7924486F0518F0B0310-MsuGFMq8XAE@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: stanley zhou <stanleyru-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Cc: davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, laurent.navet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, firedtoad-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, YOSHIFUJI Hideaki <yoshfuji-VfPWfsRibaP+Ru+s062T9g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

stanley zhou wrote:

> when call write_lock_bh() table is null cause crash in __ip6_del_rt().
> kernel version is 2.6.30.10
:
> static int __ip6_del_rt(struct rt6_info *rt, struct nl_info *info)
> {
> int err;
> struct fib6_table *table;
> struct net *net = dev_net(rt->rt6i_dev);
> 
> if (rt == net->ipv6.ip6_null_entry) {
> +++err = -ENOENT;
> +++goto out;
> --- return -ENOENT;
> }
> 
> table = rt->rt6i_table;
> write_lock_bh(&table->tb6_lock);
> err = fib6_del(rt, info);
> write_unlock_bh(&table->tb6_lock);
> +++out:
> dst_release(&rt->u.dst);
> return err;
> } 
>  

I think this is what commit 6825a26c ("ipv6: release reference of
ip6_null_entry's dst entry in __ip6_del_rt") by Gao feng
<gaofeng-BthXqXjhjHXQFUHtdCDX3A@public.gmane.org> does, which is already in v3.7.

Are you suggesting that we should have this in -stable tree as well?

--yoshfuji

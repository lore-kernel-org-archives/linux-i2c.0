From: Alasdair G Kergon <agk-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [dm-devel] idr_get_new_exact ?
Date: Mon, 20 Sep 2010 22:38:25 +0100
Message-ID: <20100920213825.GF30622__9703.36404066092$1285018826$gmane$org@agk-dp.fab.redhat.com>
References: <AANLkTi=ZLupVyFR0e2v-TLpeNWdw1bVMZUAhgyxLJ7OV@mail.gmail.com> <adaiq20f90h.fsf@cisco.com> <4C97D197.9070703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4C97D197.9070703-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: device-mapper development <dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Roland Dreier <rdreier-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Steve Wise <swise-ut6Up61K2wZBDgjK7y7TUQ@public.gmane.org>, linux-
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 20, 2010 at 11:26:47PM +0200, Tejun Heo wrote:
> I agree.  Wouldn't those users better off simply using radix tree?
 
Can't speak for the other users, but dm uses it both ways - normally
happy with any id (minor number), but sometimes user requires a specific
one.

Alasdair

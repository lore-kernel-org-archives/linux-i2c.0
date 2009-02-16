From: Clifford Wolf <clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>
Subject: Re: + i2c-fix-i2c-mpc-driver-for-multi-master-i2c-busses.patch
	added to -mm tree
Date: Mon, 16 Feb 2009 13:41:13 +0100
Message-ID: <20090216124112.GA15317@clifford.at>
References: <200812222101.mBML1kn7021201@imap1.linux-foundation.org> <200902151653.36860.david-b@pacbell.net> <20090216092000.13af2d74@hyperion.delvare> <200902160358.48176.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200902160358.48176.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On Mon, Feb 16, 2009 at 03:58:47AM -0800, David Brownell wrote:
> I must have missed that.  It's not correct, in any case.
> Messages can easily have been *partially* transmitted.
> 
> Loss of arbitration appears at the first transmitted bit
> where one master sends '0' and overrides another, which
> is sending '1' instead.  Ideally it's while addressing a
> device, but it could be after some data bytes have been
> sent ... and, depending on the slave, acted upon.  Even
> after one or more repeated starts.

the master then wins the conflict continues sending its message to the
slave. so the slave never recieves a partial message.

therefore the partially transmitted problem is none and retrying after
arbritration lost is always safe.

yours,
 - clifford

-- 
Relax, its only ONES and ZEROS!

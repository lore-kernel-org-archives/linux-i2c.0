From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Registering i2c devices with Device Tree
Date: Sun, 25 Mar 2012 20:41:50 +0200
Message-ID: <20120325204150.20d3dcdb@endymion.delvare>
References: <CAKON4Oy5hSpDS4mpJHL-Nk95+9MMSwUqE6TXnvH2wn2XaNA68Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKON4Oy5hSpDS4mpJHL-Nk95+9MMSwUqE6TXnvH2wn2XaNA68Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 25 Mar 2012 13:29:51 -0400, jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> All of the OF aware i2c bus drivers need to do:
> 	of_i2c_register_devices(&alg_data->adapter);
> 
> Can this be moved to the common core code?

I seem to recall that someone once proposed to move the call to
i2c-core, but the dependencies and #ifdef mess that resulted made me
reject it. That doesn't mean it can't be done, but just moving the call
is not the way.

-- 
Jean Delvare

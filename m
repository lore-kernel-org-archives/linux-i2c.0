From: "jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Registering i2c devices with Device Tree
Date: Sun, 25 Mar 2012 13:29:51 -0400
Message-ID: <CAKON4Oy5hSpDS4mpJHL-Nk95+9MMSwUqE6TXnvH2wn2XaNA68Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

All of the OF aware i2c bus drivers need to do:
	of_i2c_register_devices(&alg_data->adapter);

Can this be moved to the common core code?

-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

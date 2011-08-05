From: Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
Subject: Re: [RFC][PATCH] of: add a dummy implementation of
	of_get_property() in of.h
Date: Fri, 5 Aug 2011 11:05:14 +0200
Message-ID: <20110805090514.GA17391@distanz.ch>
References: <1312534574.18064.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1312534574.18064.2.camel@phoenix>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, John Bonesio <bones-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, "Sam Ravnborg sam"@ravnborg.org
List-Id: linux-i2c@vger.kernel.org

On 2011-08-05 at 10:56:14 +0200, Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Then we can avoid having #ifdef CONFIG_OF splattered around the place
> calling of_get_property(), it leads to errors.

You shouldn't redefine of_get_property in the driver. Rather add a
wrapper function to the driver which will extract the device tree
information in CONFIG_OF is enabled and which will just return -ENODEV
if CONFIG_OF is not set.

Cheers
Tobias

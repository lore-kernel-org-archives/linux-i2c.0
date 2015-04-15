From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/4] parport: modify parport subsystem to use devicemodel
Date: Wed, 15 Apr 2015 12:45:00 +0300
Message-ID: <20150415094500.GZ16501@mwanda>
References: <1429084124-2271-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1429084124-2271-2-git-send-email-sudipm.mukherjee@gmail.com>
 <20150415082746.GI10964@mwanda> <20150415092055.GA3198@sudip-PC>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <20150415092055.GA3198@sudip-PC>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: devel@driverdev.osuosl.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Wolfram Sang <wsa@the-dreams.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Willy Tarreau <willy@meta-x.org>, Jean Delvare <jdelvare@suse.de>
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 15, 2015 at 02:50:55PM +0530, Sudip Mukherjee wrote:
> <snip>
> > > +	tmp->name = name;
> > 
> > I wonder who frees this name variable.  My concern is that it gets
> > freed before we are done using it or something.  (I have not looked at
> > the details).
> it will be done in free_port() the release callback of parport device.

That doesn't work.  Some of the callers pass a string literal.

regards,
dan carpenter

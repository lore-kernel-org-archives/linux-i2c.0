From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH 1/4] parport: modify parport subsystem to use devicemodel
Date: Wed, 15 Apr 2015 14:54:40 +0530
Message-ID: <20150415092440.GB3198@sudip-PC>
References: <1429084124-2271-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1429084124-2271-2-git-send-email-sudipm.mukherjee@gmail.com>
 <20150415083359.GJ10964@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150415083359.GJ10964@mwanda>
Sender: linux-doc-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@the-dreams.de>, Willy Tarreau <willy@meta-x.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-i2c@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 15, 2015 at 11:33:59AM +0300, Dan Carpenter wrote:
> On Wed, Apr 15, 2015 at 01:18:41PM +0530, Sudip Mukherjee wrote:
> 
> 
> The difference between parport_register_device() and
> parport_register_dev() isn't clear from the name.
i kept the name similar deliberately as I thought that after all the
drivers are modified to use these new api the old functions will be
removed so then this name will have some meaning.

so, should i send a v2 now with the changes you suggested or should we
wait for some review about the functionality and testing?


regards
sudip
> 
> regards,
> dan carpenter
> 

From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 09/26] docs: i2c: i2c-protocol: remove unneeded colons
 from table
Date: Mon, 20 Jan 2020 15:22:17 +0100
Message-ID: <20200120152217.5f290971@endymion>
References: <20200105224006.10321-1-luca@lucaceresoli.net>
        <20200105225012.11701-1-luca@lucaceresoli.net>
        <20200105225012.11701-9-luca@lucaceresoli.net>
        <20200120143852.02b2c185@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200120143852.02b2c185@endymion>
Sender: linux-kernel-owner@vger.kernel.org
To: Luca Ceresoli <luca@lucaceresoli.net>
Cc: linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Ah, actually...

On Mon, 20 Jan 2020 14:38:52 +0100, Jean Delvare wrote:
> On Sun,  5 Jan 2020 23:49:55 +0100, Luca Ceresoli wrote:
> > These colons are not needed: the columns already nicely separate the
> > symbold from their description. They are also inconsistently preceded by

... you have a typo there, s/symbold/symbols/.

> > whitespace.
> > 
> > Remove the colons completely to simplify and clean up.
> > 
> > Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> > ---
> >  Documentation/i2c/i2c-protocol.rst | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> > (...)  
> 
> Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

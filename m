From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 15/26] docs: i2c: smbus-protocol: enable kernel-doc
 function syntax
Date: Wed, 22 Jan 2020 12:48:59 +0100
Message-ID: <20200122124859.52ceac75@endymion>
References: <20200105224006.10321-1-luca@lucaceresoli.net>
        <20200105225012.11701-1-luca@lucaceresoli.net>
        <20200105225012.11701-15-luca@lucaceresoli.net>
        <20200120154444.7c1d3863@endymion>
        <211da679-154f-15e3-52d3-a24d50c526cf@lucaceresoli.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <211da679-154f-15e3-52d3-a24d50c526cf@lucaceresoli.net>
Sender: linux-doc-owner@vger.kernel.org
To: Luca Ceresoli <luca@lucaceresoli.net>
Cc: linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 21 Jan 2020 18:31:23 +0100, Luca Ceresoli wrote:
> By extrapolation I guess you want to review the few remaining patches.
> Correnct? In this case I'd wait for that before sending out v2.

Yes, and I'm just done with it. Sorry it took so long but I was doing
it as a background task as my work schedule allowed.

One last thing you may want to fix: there's one occurrence of "stop
bit" left in Documentation/i2c/writing-clients.rst.

Thanks,
-- 
Jean Delvare
SUSE L3 Support

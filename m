From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 15/26] docs: i2c: smbus-protocol: enable kernel-doc
 function syntax
Date: Wed, 22 Jan 2020 15:26:08 +0100
Message-ID: <20200122152608.40f7c90c@endymion>
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
> Good point. For v2 I added a new patch to use "Implemented by" also in
> i2c-protocol.rst.

BTW... I don't know how Wolfram feels about it, but I don't think
documentation changes need to be split to such fine-grained patches.
Chances that someone will want to cherry-pick specific changes are very
low in my opinion, so a large number of patches only means more
paperwork with little to no benefit. Some splitting is certainly nice
to make reviews easier, but only to a certain degree.

-- 
Jean Delvare
SUSE L3 Support

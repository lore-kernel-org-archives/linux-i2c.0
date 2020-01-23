From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [PATCH 15/26] docs: i2c: smbus-protocol: enable kernel-doc
 function syntax
Date: Thu, 23 Jan 2020 10:51:29 +0100
Message-ID: <37504278-2fea-f894-542c-c0a4f142eb9e@lucaceresoli.net>
References: <20200105224006.10321-1-luca@lucaceresoli.net>
 <20200105225012.11701-1-luca@lucaceresoli.net>
 <20200105225012.11701-15-luca@lucaceresoli.net>
 <20200120154444.7c1d3863@endymion>
 <211da679-154f-15e3-52d3-a24d50c526cf@lucaceresoli.net>
 <20200122152608.40f7c90c@endymion> <20200122153747.GA21343@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200122153747.GA21343@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>
Cc: linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 22/01/20 16:37, Wolfram Sang wrote:
> On Wed, Jan 22, 2020 at 03:26:08PM +0100, Jean Delvare wrote:
>> On Tue, 21 Jan 2020 18:31:23 +0100, Luca Ceresoli wrote:
>>> Good point. For v2 I added a new patch to use "Implemented by" also in
>>> i2c-protocol.rst.
>>
>> BTW... I don't know how Wolfram feels about it, but I don't think
>> documentation changes need to be split to such fine-grained patches.
> 
> I don't mind too much. I think for a first version, fine grained can
> make review more easy. Maybe the second version could be less patches.
> Yet for me, since patchwork can handle series of patches, the amount
> doesn't matter too much. I am super happy that Luca did the work and you
> did the review!

I initially split this work in fine-grained patches for better reviewing
and also because some of the changes were not expected in the beginning:
while working at an improvement I noticed an unrelated one was needed.
But I agree the result is quite awkward. Coalescing some of them now
would be painful, so I'm sending v2 as is. But I'm tackling the
remaining sections later, and I'm going to do that work in a smaller
number of patches.

-- 
Luca

From: Peter Rosin <peda@axentia.se>
Subject: Re: [PULL REQUEST] i2c-mux for 4.15-rc1
Date: Fri, 27 Oct 2017 23:05:16 +0200
Message-ID: <d7225ec1-8d47-ee9f-8f80-3c9fe2f42a96@axentia.se>
References: <21496b51-370f-2009-b25c-881c524fe2b9@axentia.se>
 <20171027192757.utcn6duckmfmbvi6@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-he1eur01on0138.outbound.protection.outlook.com ([104.47.0.138]:49120
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932329AbdJ0VFY (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 27 Oct 2017 17:05:24 -0400
In-Reply-To: <20171027192757.utcn6duckmfmbvi6@ninjato>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 2017-10-27 21:27, Wolfram Sang wrote:
> Hi Peda,
> 
>> This cycle has been real quiet for me. There's only the one trivial patch
>> that somewhat simplifies DT parsing in the i2c-mux-reg driver.
> 
> Did this maybe slip through the cracks?
> 
> http://patchwork.ozlabs.org/patch/816846/
> 
> ("[trivial] dt-bindings: i2c: i2c-mux: Spelling s/required is/required
> if/")

Right. Blush. I blame the immense flow of patches. I just can't seem to
keep up... :-) Anyway, thanks for catching this and sorry for making you
do that.

Some words for the merge commit:

This trivial patch managed to fall through the cracks and was forgotten
in the first pull request, as noticed by Wolfram. Thanks.

Please pull.

Cheers,
Peter

The following changes since commit 3997fb74846f35d0364c5e88e54bc9b166d5a1bc:

  i2c: mux: reg: use of_property_read_bool() (2017-10-20 16:33:07 +0200)

are available in the git repository at:

  https://github.com/peda-r/i2c-mux.git tags/i2c-mux/for-4.15-2

for you to fetch changes up to fcc046801b934ad27ba80e20e3e0f4c97957af58:

  dt-bindings: i2c: i2c-mux: spelling s/required is/required if/ (2017-10-27 22:45:28 +0200)

----------------------------------------------------------------
Geert Uytterhoeven (1):
      dt-bindings: i2c: i2c-mux: spelling s/required is/required if/

 Documentation/devicetree/bindings/i2c/i2c-mux.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

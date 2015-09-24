From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v2] i2c-ocores: support big-endian register layout
Date: Fri, 25 Sep 2015 00:20:04 +0300
Message-ID: <CAMo8BfKh_bF-MbmsFGzTdrsqyGeTDqthDzfsRxsTnAgYBBHGhg@mail.gmail.com>
References: <1442990103-13456-1-git-send-email-jcmvbkbc@gmail.com>
	<87wpvfoaly.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:33906 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbbIXVUF (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 24 Sep 2015 17:20:05 -0400
In-Reply-To: <87wpvfoaly.fsf@dell.be.48ers.dk>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Korsgaard <peter@korsgaard.com>
Cc: linux-i2c@vger.kernel.org, Peter Korsgaard <jacmet@sunsite.dk>, Wolfram Sang <wsa@the-dreams.de>, LKML <linux-kernel@vger.kernel.org>

Peter,

On Thu, Sep 24, 2015 at 10:55 PM, Peter Korsgaard <peter@korsgaard.com> wrote:
>>>>>> "Max" == Max Filippov <jcmvbkbc@gmail.com> writes:
>
>  > This allows using OpenCores I2C controller attached to its host in
>  > native-endian mode with bi-endian CPUs. Example of such system is Xtensa
>  > XTFPGA platform.
>
>  > Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
>  > ---
>  > Changes v1->v2:
>  > - expand changelog with motivation for the change.
>
> You should also document the big-endian property in
> Documentation/devicetree/bindings/i2c/i2c-ocores.txt, otherwise it looks
> good.

'big-endian' and 'native-endian' are common properties documented
in the Documentation/devicetree/bindings/common-properties.txt

-- 
Thanks.
-- Max

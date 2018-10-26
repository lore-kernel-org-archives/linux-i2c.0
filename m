From: Peter Korsgaard <peter@korsgaard.com>
Subject: Re: [PATCH 1/3] i2c:ocores: stop transfer on timeout
Date: Fri, 26 Oct 2018 19:46:41 +0200
Message-ID: <87sh0s38ji.fsf@dell.be.48ers.dk>
References: <20180625161303.7991-1-federico.vaga@cern.ch>
        <20180625161303.7991-2-federico.vaga@cern.ch>
        <CACXmVia0vStmBwd4ndFk6UjE9wGsjp7Y75ej0AGq68H8-XkZqw@mail.gmail.com>
        <1549360.saVjYH78Bt@pcbe13614>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549360.saVjYH78Bt@pcbe13614> (Federico Vaga's message of "Wed,
        24 Oct 2018 16:51:04 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Federico Vaga <federico.vaga@cern.ch>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, linux-i2c <linux-i2c@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "Federico" == Federico Vaga <federico.vaga@cern.ch> writes:

Hi,

 > I had another look at the HDL code and apparently my assumption was wrong, and 
 > STOP just do stop, and IACK is still necessary.

 > So, yes, without try is better because we save an extra, useless, IRQ call

Ok, great!

-- 
Bye, Peter Korsgaard

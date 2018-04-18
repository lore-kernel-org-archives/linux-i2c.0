From: Sam Hansen <hansens@google.com>
Subject: Re: [PATCH v3 2/3] Documentation/i2c: sync docs with current state of i2c-tools
Date: Wed, 18 Apr 2018 11:17:55 -0700
Message-ID: <CAP9bUy4vZB1LVjLdm7WvrebBF4tSB32WjC+h0PEoyaCFjdfhUg@mail.gmail.com>
References: <20180413174257.139182-1-hansens@google.com> <20180413174257.139182-2-hansens@google.com>
 <20180418082130.5oqgy7xsja5qucov@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180418082130.5oqgy7xsja5qucov@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 18, 2018 at 1:21 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> +The above functions are made available by linking against the libi2c library,
>> +which is provided by the i2c-tools project.  See:
>> +https://git.kernel.org/pub/scm/utils/i2c-tools/i2c-tools.git/.
>
> In the beginning, we say that '#include <i2c/smbus.h>' is needed.
> Shouldn't we mention i2c-tools there already and in what case it is
> needed (only for SMBus)? I'd think so.
>
> Sam, would you be open to do this as an incremental patch?

Yup, I'll send an incremental patch touching this up, thanks.

>

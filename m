From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] i2c-dev: Don't block the adapter from unregistering
Date: Mon, 18 Jul 2016 13:20:05 -0700
Message-ID: <20160718202005.GA18283@ubuntu>
References: <cover.1467772840.git.viresh.kumar@linaro.org>
 <021486be2f5425ce2379219a7ac163ee14ba2aba.1467772840.git.viresh.kumar@linaro.org>
 <20160706065523.GA1439@tetsubishi>
 <20160706191218.483fd9fd@endymion>
 <20160706205540.GJ4127@ubuntu>
 <20160711142209.4711f229@endymion>
 <20160711215058.GA7808@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160711215058.GA7808@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, Greg KH <gregkh@linuxfoundation.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, Alex Elder <elder@linaro.org>
List-Id: linux-i2c@vger.kernel.org

On 11-07-16, 14:50, Greg KH wrote:
> Ideally, yes, userspace will have closed that device node.  But again,
> hardware isn't kind and sometimes decides to be yanked out by users
> before they tell the kernel about it.  We handle this for almost all
> other device subsystems, i2c is one of the last to be fixed up in this
> manner.  Sorry it's taken us well over a decade to get here :)
> 
> hope that explains things better,

@Jean: Ping :)

-- 
viresh

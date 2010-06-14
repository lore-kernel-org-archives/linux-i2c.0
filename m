From: Edward Shishkin <edward.shishkin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/8]reiserfs:stree.c Fix variable set but not used.
Date: Mon, 14 Jun 2010 23:05:46 +0200
Message-ID: <4C1699AA.3000900@gmail.com>
References: <1276547208-26569-1-git-send-email-justinmattock@gmail.com> <1276547208-26569-2-git-send-email-justinmattock@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1276547208-26569-2-git-send-email-justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Justin P. Mattock" <justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, reiserfs-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org, debora-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux1394-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Justin P. Mattock wrote:
> Not sure if this is correct or not.
> the below patch gets rid of this warning message
> produced by gcc 4.6.0
>
> fs/reiserfs/stree.c: In function 'search_by_key':
> fs/reiserfs/stree.c:602:6: warning: variable 'right_neighbor_of_leaf_node' set but not used
>
>  Signed-off-by: Justin P. Mattock <justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>   

Acked-by: Edward Shishkin <edward.shishkin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

> ---
>  fs/reiserfs/stree.c |    7 ++-----
>  1 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
> index 313d39d..73086ad 100644
> --- a/fs/reiserfs/stree.c
> +++ b/fs/reiserfs/stree.c
> @@ -599,7 +599,6 @@ int search_by_key(struct super_block *sb, const struct cpu_key *key,	/* Key to s
>  	struct buffer_head *bh;
>  	struct path_element *last_element;
>  	int node_level, retval;
> -	int right_neighbor_of_leaf_node;
>  	int fs_gen;
>  	struct buffer_head *reada_bh[SEARCH_BY_KEY_READA];
>  	b_blocknr_t reada_blocks[SEARCH_BY_KEY_READA];
> @@ -617,8 +616,7 @@ int search_by_key(struct super_block *sb, const struct cpu_key *key,	/* Key to s
>  
>  	pathrelse(search_path);
>  
> -	right_neighbor_of_leaf_node = 0;
> -
> +	
>  	/* With each iteration of this loop we search through the items in the
>  	   current node, and calculate the next current node(next path element)
>  	   for the next iteration of this loop.. */
> @@ -695,8 +693,7 @@ int search_by_key(struct super_block *sb, const struct cpu_key *key,	/* Key to s
>  			   starting from the root. */
>  			block_number = SB_ROOT_BLOCK(sb);
>  			expected_level = -1;
> -			right_neighbor_of_leaf_node = 0;
> -
> +			
>  			/* repeat search from the root */
>  			continue;
>  		}
>   

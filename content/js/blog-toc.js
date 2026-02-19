(function() {
  'use strict';

  document.addEventListener('DOMContentLoaded', function() {
    const tocList = document.querySelector('.app-post-toc__list');
    const blogContent = document.querySelector('.blog-content');
    const tocContainer = document.querySelector('.app-post-toc');


    if (!tocList || !blogContent || !tocContainer) {
      return;
    }

    const headings = blogContent.querySelectorAll('h2, h3');

    if (headings.length === 0) {
      const noContentItem = document.createElement('li');
      noContentItem.textContent = 'No sections available';
      noContentItem.style.fontStyle = 'italic';
      noContentItem.style.color = 'var(--color--secondary)';
      noContentItem.style.fontSize = '0.8125rem';
      tocList.appendChild(noContentItem);
      return;
    }

    const fragment = document.createDocumentFragment();
    let currentH2Item = null;
    let currentH3List = null;

    headings.forEach(function(heading, index) {
    
      if (!heading.id) {
        heading.id = 'heading-' + index;
      }

      const listItem = document.createElement('li');
      const link = document.createElement('a');
      link.href = '#' + heading.id;
      link.textContent = heading.textContent;
      link.setAttribute('data-heading-id', heading.id);


      link.addEventListener('click', function(e) {
        e.preventDefault();
        const target = document.getElementById(heading.id);
        if (target) {
          const offset = 100; 
          const targetPosition = target.getBoundingClientRect().top + window.pageYOffset - offset;
          window.scrollTo({
            top: targetPosition,
            behavior: 'smooth'
          });
          
          history.pushState(null, null, '#' + heading.id);
        }
      });

      listItem.appendChild(link);

      if (heading.tagName.toLowerCase() === 'h2') {
       
        currentH2Item = listItem;
        currentH3List = null;
        fragment.appendChild(listItem);
      } else if (heading.tagName.toLowerCase() === 'h3') {
  
        if (currentH2Item) {
          if (!currentH3List) {
            currentH3List = document.createElement('ul');
            currentH2Item.appendChild(currentH3List);
          }
          currentH3List.appendChild(listItem);
        } else {

          fragment.appendChild(listItem);
        }
      }
    });

    tocList.appendChild(fragment);


    const tocLinks = tocList.querySelectorAll('a');
    const headingsArray = Array.from(headings);

    function updateActiveLink() {
      const scrollPosition = window.scrollY + 150; 

      let currentHeading = null;


      for (let i = headingsArray.length - 1; i >= 0; i--) {
        const heading = headingsArray[i];
        if (heading.offsetTop <= scrollPosition) {
          currentHeading = heading;
          break;
        }
      }


      tocLinks.forEach(function(link) {
        link.classList.remove('active');
        if (currentHeading && link.getAttribute('data-heading-id') === currentHeading.id) {
          link.classList.add('active');
        }
      });
    }

    let ticking = false;
    window.addEventListener('scroll', function() {
      if (!ticking) {
        window.requestAnimationFrame(function() {
          updateActiveLink();
          ticking = false;
        });
        ticking = true;
      }
    });


    updateActiveLink();
  });
})();

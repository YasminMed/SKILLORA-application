import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';


enum NoteCategory { computer_science, mathematics, project }


class NoteAttachment {
  final String id;
  final String name;
  final String size;
  final String? url;

  NoteAttachment({
    required this.id,
    required this.name,
    required this.size,
    this.url,
  });
}


class Note {
  final String id;
  final String title;
  final String content;
  final NoteCategory category;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> tags;
  final List<NoteAttachment> attachments;
  final bool isPinned;
  final Color? customColor;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    required this.tags,
    required this.attachments,
    this.isPinned = false,
    this.customColor,
  });

  Color get categoryColor {
    if (customColor != null) return customColor!;
    switch (category) {
      case NoteCategory.computer_science:
        return AppColors.primary;
      case NoteCategory.mathematics:
        return AppColors.accent;
      case NoteCategory.project:
        return AppColors.darkBrown;
    }
  }

  String get categoryName {
    switch (category) {
      case NoteCategory.computer_science:
        return 'Computer Science';
      case NoteCategory.mathematics:
        return 'Mathematics';
      case NoteCategory.project:
        return 'Project';
    }
  }

  IconData get categoryIcon {
    switch (category) {
      case NoteCategory.computer_science:
        return Icons.computer;
      case NoteCategory.mathematics:
        return Icons.calculate;
      case NoteCategory.project:
        return Icons.folder;
    }
  }

  String get formattedDate {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[updatedAt.month - 1]} ${updatedAt.day}, ${updatedAt.year}';
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(updatedAt);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) return 'Just now';
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()}w ago';
    } else {
      return formattedDate;
    }
  }
}



class NotesWidget extends StatefulWidget {
  const NotesWidget({Key? key}) : super(key: key);

  @override
  _NotesWidgetState createState() => _NotesWidgetState();
}

class _NotesWidgetState extends State<NotesWidget> {
  final TextEditingController _searchController = TextEditingController();
  String selectedCategory = 'All';
  bool isGridView = false;
  String searchQuery = '';

  final List<Note> notes = [
    Note(
      id: '1',
      title: 'Data Structures Final Review',
      content: 'Key concepts: Binary Search Trees, Hash Tables, Graph Algorithms.',
      category: NoteCategory.computer_science,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
      tags: ['algorithms', 'exam'],
      attachments: [
        NoteAttachment(
          id: 'a1',
          name: 'BST_Notes.pdf',
          size: '1.2 MB',
        ),
      ],
      isPinned: true,
    ),
    Note(
      id: '2',
      title: 'Linear Algebra - Matrix Operations',
      content: 'Matrix multiplication rules, determinants, eigenvalues and eigenvectors.',
      category: NoteCategory.mathematics,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      tags: ['math', 'homework'],
      attachments: [],
      isPinned: true,
    ),
    Note(
      id: '3',
      title: 'E-commerce Project Tasks',
      content: 'Todo: Complete payment gateway integration, add product search filters.',
      category: NoteCategory.project,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 5)),
      tags: ['project', 'development'],
      attachments: [],
    ),
  ];

  List<Note> get filteredNotes {
    List<Note> filtered = notes;

    if (selectedCategory != 'All') {
      filtered = filtered.where((note) => note.categoryName == selectedCategory).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((note) {
        return note.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
            note.content.toLowerCase().contains(searchQuery.toLowerCase()) ||
            note.tags.any((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()));
      }).toList();
    }

    filtered.sort((a, b) {
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;
      return b.updatedAt.compareTo(a.updatedAt);
    });

    return filtered;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalNotes = notes.length;
    final pinnedNotes = notes.where((n) => n.isPinned).length;
    final withAttachments = notes.where((n) => n.attachments.isNotEmpty).length;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.limeGreen.withOpacity(0.15),
            AppColors.white,
            AppColors.softGreen.withOpacity(0.10),
          ],
        ),
      ),
      child: Column(
        children: [
          _buildAppBar(context),
          const SizedBox(height: 24),
          _buildStatsCards(totalNotes, pinnedNotes, withAttachments),
          _buildFilterChips(),
          Expanded(child: _buildNotesList()),
        ],
      ),
    );
  }


 Widget _buildAppBar(BuildContext context) {
  return SafeArea(
    child: Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.accent],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ------- CENTERED TITLE -------
          Text(
            'My Notes',
            style: AppTextStyles.h2.copyWith(
              color: AppColors.white,
              fontSize: 20,
            ),
          ),
    
          // ------- RIGHT ACTION BUTTON -------
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => setState(() => isGridView = !isGridView),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isGridView ? Icons.view_list : Icons.grid_view,
                  color: AppColors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}



  Widget _buildStatsCards(int total, int pinned, int withFiles) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.white, AppColors.limeGreen.withOpacity(0.2)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.limeGreen.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem('Total', '$total', Icons.note_outlined, AppColors.primary),
          ),
          Container(width: 1, height: 40, color: AppColors.grey.withOpacity(0.2)),
          Expanded(
            child: _buildStatItem('Pinned', '$pinned', Icons.push_pin, AppColors.accent),
          ),
          Container(width: 1, height: 40, color: AppColors.grey.withOpacity(0.2)),
          Expanded(
            child: _buildStatItem('Files', '$withFiles', Icons.attach_file, AppColors.softGreen),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(value, style: AppTextStyles.h2.copyWith(color: color, fontSize: 20)),
        Text(label, style: AppTextStyles.tiny.copyWith(color: AppColors.grey, fontSize: 11)),
      ],
    );
  }



  Widget _buildFilterChips() {
    final categories = ['All', 'Computer Science', 'Mathematics', 'Project'];

    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 12),
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => setState(() => selectedCategory = category),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? const LinearGradient(colors: [AppColors.primary, AppColors.accent])
                      : null,
                  color: isSelected ? null : AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.grey.withOpacity(0.2)),
                  boxShadow: [
                    BoxShadow(
                      color: isSelected
                          ? AppColors.primary.withOpacity(0.3)
                          : AppColors.black.withOpacity(0.05),
                      blurRadius: isSelected ? 8 : 5,
                    )
                  ],
                ),
                child: Text(
                  category,
                  style: AppTextStyles.label.copyWith(
                    color: isSelected ? AppColors.white : AppColors.grey,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }


  Widget _buildNotesList() {
    return isGridView
        ? GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemCount: filteredNotes.length,
            itemBuilder: (context, index) => _buildNoteCardGrid(filteredNotes[index]),
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            itemCount: filteredNotes.length,
            itemBuilder: (context, index) => _buildNoteCardList(filteredNotes[index]),
          );
  }


  Widget _buildNoteCardList(Note note) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.white, note.categoryColor.withOpacity(0.08)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: note.categoryColor.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: note.categoryColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(note.categoryIcon, color: note.categoryColor, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (note.isPinned) ...[
                          Icon(Icons.push_pin, size: 14, color: note.categoryColor),
                          const SizedBox(width: 4),
                        ],
                        Expanded(
                          child: Text(
                            note.title,
                            style: AppTextStyles.button.copyWith(
                              color: AppColors.black.withOpacity(0.87),
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      note.categoryName,
                      style: AppTextStyles.tiny.copyWith(color: note.categoryColor, fontSize: 11),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: AppColors.grey.withOpacity(0.4), size: 20),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            note.content,
            style: AppTextStyles.small.copyWith(color: AppColors.grey, fontSize: 13, height: 1.5),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }


  Widget _buildNoteCardGrid(Note note) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.white, note.categoryColor.withOpacity(0.12)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: note.categoryColor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: note.categoryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(note.categoryIcon, color: note.categoryColor, size: 20),
              ),
              if (note.isPinned)
                Icon(Icons.push_pin, size: 16, color: note.categoryColor),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            note.title,
            style: AppTextStyles.button.copyWith(
              color: AppColors.black.withOpacity(0.87),
              fontSize: 15,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Text(
              note.content,
              style: AppTextStyles.small.copyWith(color: AppColors.grey, fontSize: 12, height: 1.4),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
